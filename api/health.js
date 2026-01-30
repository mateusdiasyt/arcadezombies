const { pool, cors, json } = require('./lib/db');

module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'GET') {
    return json(res, 405, { error: 'Method not allowed' });
  }
  if (!pool) {
    return json(res, 200, { ok: true, db: 'not_configured' });
  }
  try {
    await pool.query('SELECT 1');
    return json(res, 200, { ok: true, db: 'ok' });
  } catch (e) {
    return json(res, 503, { ok: false, db: 'erro' });
  }
};
