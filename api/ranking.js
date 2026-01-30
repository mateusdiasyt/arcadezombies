const { sql, getRankFromPDL, cors, json } = require('./lib/db');

module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'GET') {
    return json(res, 405, { error: 'Method not allowed' });
  }
  if (!sql) {
    return json(res, 503, { error: 'Banco não configurado (DATABASE_URL)' });
  }
  const limit = Math.min(parseInt(req.query?.limit, 10) || 50, 100);
  const rows = await sql`
    SELECT id, username, pdl FROM accounts ORDER BY pdl DESC LIMIT ${limit}
  `;
  return json(res, 200, rows.map((row) => ({
    id: row.id,
    username: row.username,
    pdl: row.pdl,
    rank: getRankFromPDL(row.pdl),
  })));
};
