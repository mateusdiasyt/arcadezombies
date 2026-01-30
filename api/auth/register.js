const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { pool, getRankFromPDL, cors, json } = require('../lib/db');
const { JWT_SECRET } = require('../lib/auth');

module.exports = async function handler(req, res) {
  try {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'POST') {
    return json(res, 405, { error: 'Method not allowed' });
  }
  if (!pool) {
    return json(res, 503, { error: 'Banco não configurado (DATABASE_URL)' });
  }
  let body = req.body || {};
  if (typeof req.body === 'string') {
    try { body = JSON.parse(req.body || '{}'); } catch (_) { body = {}; }
  }
  const { username, email, password } = body;
  if (!username || !password) {
    return json(res, 400, { error: 'username e password são obrigatórios' });
  }
  if (username.length < 2 || username.length > 64) {
    return json(res, 400, { error: 'username entre 2 e 64 caracteres' });
  }
  let hash;
  try {
    hash = await bcrypt.hash(password, 10);
  } catch (e) {
    console.error('bcrypt.hash', e);
    return json(res, 500, { error: 'Erro ao processar senha' });
  }
  try {
    const r = await pool.query(
      `INSERT INTO accounts (username, email, password_hash)
       VALUES ($1, $2, $3)
       RETURNING id, username, email, pdl, created_at`,
      [username.trim(), (email && email.trim()) || null, hash]
    );
    const row = r.rows && r.rows[0] ? r.rows[0] : null;
    if (!row) {
      console.error('INSERT RETURNING sem linha:', r.rows);
      return json(res, 500, { error: 'Erro ao criar conta' });
    }
    const token = jwt.sign(
      { userId: row.id, username: row.username },
      JWT_SECRET,
      { expiresIn: '7d' }
    );
    return json(res, 201, {
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
      return json(res, 409, { error: 'username ou email já em uso' });
    }
    if (e.code === '42P01' || (e.message && e.message.includes('does not exist'))) {
      return json(res, 503, { error: 'Tabelas não criadas. Execute o schema na Neon (veja NEON_CRIAR_TABELAS.md).' });
    }
    console.error('register', e);
    return json(res, 500, {
      error: 'Erro ao criar conta',
      detail: e.message || String(e)
    });
  }
  } catch (outer) {
    console.error('register outer', outer);
    cors(res);
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    res.status(500).json({
      error: 'Erro ao criar conta',
      detail: outer.message || String(outer)
    });
  }
};
