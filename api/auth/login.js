const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { sql, getRankFromPDL, cors, json } = require('../lib/db');
const { JWT_SECRET } = require('../lib/auth');

module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'POST') {
    return json(res, 405, { error: 'Method not allowed' });
  }
  if (!sql) {
    return json(res, 503, { error: 'Banco não configurado (DATABASE_URL)' });
  }
  const body = typeof req.body === 'string' ? JSON.parse(req.body || '{}') : (req.body || {});
  const { username, email, password } = body;
  const login = username || email;
  if (!login || !password) {
    return json(res, 400, { error: 'username/email e password são obrigatórios' });
  }
  const rows = await sql`
    SELECT id, username, email, password_hash, pdl
    FROM accounts WHERE username = ${login.trim()} OR email = ${login.trim()}
  `;
  if (rows.length === 0) {
    return json(res, 401, { error: 'Usuário ou senha inválidos' });
  }
  const row = rows[0];
  const ok = await bcrypt.compare(password, row.password_hash);
  if (!ok) {
    return json(res, 401, { error: 'Usuário ou senha inválidos' });
  }
  const token = jwt.sign(
    { userId: row.id, username: row.username },
    JWT_SECRET,
    { expiresIn: '7d' }
  );
  return json(res, 200, {
    token,
    user: {
      id: row.id,
      username: row.username,
      email: row.email,
      pdl: row.pdl,
      rank: getRankFromPDL(row.pdl),
    },
  });
};
