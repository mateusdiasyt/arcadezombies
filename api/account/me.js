const { pool, getRankFromPDL, cors, json } = require('../lib/db');
const { getAuth } = require('../lib/auth');

module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'GET') {
    return json(res, 405, { error: 'Method not allowed' });
  }
  if (!pool) {
    return json(res, 503, { error: 'Banco não configurado (DATABASE_URL)' });
  }
  const auth = getAuth(req);
  if (!auth) {
    return json(res, 401, { error: 'Token ausente ou inválido' });
  }
  const r = await pool.query(
    'SELECT id, username, email, pdl, created_at FROM accounts WHERE id = $1',
    [auth.userId]
  );
  const rows = r.rows;
  if (rows.length === 0) {
    return json(res, 404, { error: 'Conta não encontrada' });
  }
  const row = rows[0];
  return json(res, 200, {
    id: row.id,
    username: row.username,
    email: row.email,
    pdl: row.pdl,
    rank: getRankFromPDL(row.pdl),
    created_at: row.created_at,
  });
};
