require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/zombie_td',
});

const JWT_SECRET = process.env.JWT_SECRET || 'zombie-td-reborn-secret-local';
const PDL_MIN = 0;
const PDL_MAX = 3200;

/** Converte PDL em elo (0=Bronze .. 5=Mestre), igual ao Const.getRankFromPDL do jogo */
function getRankFromPDL(pdl) {
  if (pdl < 100) return 0;
  if (pdl < 200) return 1;
  if (pdl < 400) return 2;
  if (pdl < 800) return 3;
  if (pdl < 1600) return 4;
  return 5;
}

/** Middleware: extrai usuário do JWT */
function authMiddleware(req, res, next) {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Token ausente' });
  }
  try {
    const token = auth.slice(7);
    const payload = jwt.verify(token, JWT_SECRET);
    req.userId = payload.userId;
    req.username = payload.username;
    next();
  } catch (e) {
    return res.status(401).json({ error: 'Token inválido' });
  }
}

// ---- Auth ----

/** POST /auth/register - Criar conta */
app.post('/auth/register', async (req, res) => {
  const { username, email, password } = req.body || {};
  if (!username || !password) {
    return res.status(400).json({ error: 'username e password são obrigatórios' });
  }
  if (username.length < 2 || username.length > 64) {
    return res.status(400).json({ error: 'username entre 2 e 64 caracteres' });
  }
  const hash = await bcrypt.hash(password, 10);
  try {
    const r = await pool.query(
      `INSERT INTO accounts (username, email, password_hash) VALUES ($1, $2, $3)
       RETURNING id, username, email, pdl, created_at`,
      [username.trim(), (email && email.trim()) || null, hash]
    );
    const row = r.rows[0];
    const token = jwt.sign(
      { userId: row.id, username: row.username },
      JWT_SECRET,
      { expiresIn: '7d' }
    );
    res.status(201).json({
      token,
      user: {
        id: row.id,
        username: row.username,
        email: row.email,
        pdl: row.pdl,
        rank: getRankFromPDL(row.pdl),
      },
    });
  } catch (e) {
    if (e.code === '23505') {
      return res.status(409).json({ error: 'username ou email já em uso' });
    }
    console.error(e);
    return res.status(500).json({ error: 'Erro ao criar conta' });
  }
});

/** POST /auth/login - Login */
app.post('/auth/login', async (req, res) => {
  const { username, email, password } = req.body || {};
  const login = username || email;
  if (!login || !password) {
    return res.status(400).json({ error: 'username/email e password são obrigatórios' });
  }
  const r = await pool.query(
    'SELECT id, username, email, password_hash, pdl FROM accounts WHERE username = $1 OR email = $1',
    [login.trim()]
  );
  if (r.rows.length === 0) {
    return res.status(401).json({ error: 'Usuário ou senha inválidos' });
  }
  const row = r.rows[0];
  const ok = await bcrypt.compare(password, row.password_hash);
  if (!ok) {
    return res.status(401).json({ error: 'Usuário ou senha inválidos' });
  }
  const token = jwt.sign(
    { userId: row.id, username: row.username },
    JWT_SECRET,
    { expiresIn: '7d' }
  );
  res.json({
    token,
    user: {
      id: row.id,
      username: row.username,
      email: row.email,
      pdl: row.pdl,
      rank: getRankFromPDL(row.pdl),
    },
  });
});

// ---- Conta (autenticado) ----

/** GET /account/me - Dados do usuário logado */
app.get('/account/me', authMiddleware, async (req, res) => {
  const r = await pool.query(
    'SELECT id, username, email, pdl, created_at FROM accounts WHERE id = $1',
    [req.userId]
  );
  if (r.rows.length === 0) {
    return res.status(404).json({ error: 'Conta não encontrada' });
  }
  const row = r.rows[0];
  res.json({
    id: row.id,
    username: row.username,
    email: row.email,
    pdl: row.pdl,
    rank: getRankFromPDL(row.pdl),
    created_at: row.created_at,
  });
});

/** POST /account/pdl - Atualizar PDL (fim de partida: delta +3 vitória, -2 derrota) */
app.post('/account/pdl', authMiddleware, async (req, res) => {
  const delta = parseInt(req.body?.delta, 10);
  if (isNaN(delta)) {
    return res.status(400).json({ error: 'delta (número) é obrigatório' });
  }
  const client = await pool.connect();
  try {
    const r = await client.query(
      'SELECT pdl FROM accounts WHERE id = $1 FOR UPDATE',
      [req.userId]
    );
    if (r.rows.length === 0) {
      return res.status(404).json({ error: 'Conta não encontrada' });
    }
    let pdl = r.rows[0].pdl + delta;
    if (pdl < PDL_MIN) pdl = PDL_MIN;
    if (pdl > PDL_MAX) pdl = PDL_MAX;
    await client.query(
      'UPDATE accounts SET pdl = $1 WHERE id = $2',
      [pdl, req.userId]
    );
    await client.query(
      'INSERT INTO match_results (account_id, pdl_delta, pdl_after, win) VALUES ($1, $2, $3, $4)',
      [req.userId, delta, pdl, delta > 0]
    );
    res.json({ pdl, rank: getRankFromPDL(pdl) });
  } finally {
    client.release();
  }
});

// ---- Ranking ----

/** GET /ranking - Top jogadores por PDL */
app.get('/ranking', async (req, res) => {
  const limit = Math.min(parseInt(req.query?.limit, 10) || 50, 100);
  const r = await pool.query(
    `SELECT id, username, pdl FROM accounts ORDER BY pdl DESC LIMIT $1`,
    [limit]
  );
  res.json(
    r.rows.map((row) => ({
      id: row.id,
      username: row.username,
      pdl: row.pdl,
      rank: getRankFromPDL(row.pdl),
    }))
  );
});

// ---- Health (com checagem do banco) ----
app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ ok: true, db: 'ok' });
  } catch (e) {
    res.status(503).json({ ok: false, db: 'erro' });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`API Zombie TD Reborn rodando em http://localhost:${port}`);
});
