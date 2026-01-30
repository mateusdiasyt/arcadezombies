const { sql, getRankFromPDL, PDL_MIN, PDL_MAX, cors, json } = require('../lib/db');
const { getAuth } = require('../lib/auth');

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
  const auth = getAuth(req);
  if (!auth) {
    return json(res, 401, { error: 'Token ausente ou inválido' });
  }
  const body = typeof req.body === 'string' ? JSON.parse(req.body || '{}') : (req.body || {});
  const delta = parseInt(body.delta, 10);
  if (isNaN(delta)) {
    return json(res, 400, { error: 'delta (número) é obrigatório' });
  }
  const rows = await sql`
    SELECT pdl FROM accounts WHERE id = ${auth.userId}
  `;
  if (rows.length === 0) {
    return json(res, 404, { error: 'Conta não encontrada' });
  }
  let pdl = rows[0].pdl + delta;
  if (pdl < PDL_MIN) pdl = PDL_MIN;
  if (pdl > PDL_MAX) pdl = PDL_MAX;
  await sql`
    UPDATE accounts SET pdl = ${pdl} WHERE id = ${auth.userId}
  `;
  await sql`
    INSERT INTO match_results (account_id, pdl_delta, pdl_after, win)
    VALUES (${auth.userId}, ${delta}, ${pdl}, ${delta > 0})
  `;
  return json(res, 200, { pdl, rank: getRankFromPDL(pdl) });
};
