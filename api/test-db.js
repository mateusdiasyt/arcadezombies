/**
 * Endpoint temporário para testar conexão com a Neon.
 * GET /api/test-db → retorna { ok, detail, debug }.
 * Remover em produção se quiser.
 */

const { neon } = require('@neondatabase/serverless');

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
}

module.exports = async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    cors(res);
    return res.status(204).end();
  }
  if (req.method !== 'GET') {
    cors(res);
    return res.status(405).json({ error: 'Use GET' });
  }

  const debug = {
    hasDatabaseUrl: !!process.env.DATABASE_URL,
    urlLength: process.env.DATABASE_URL ? process.env.DATABASE_URL.length : 0,
    urlStart: process.env.DATABASE_URL ? process.env.DATABASE_URL.substring(0, 30) + '...' : null,
    nodeVersion: process.version,
  };

  if (!process.env.DATABASE_URL) {
    cors(res);
    return res.status(200).json({
      ok: false,
      detail: 'DATABASE_URL não está definida no Vercel (Environment Variables).',
      debug,
    });
  }

  try {
    const sql = neon(process.env.DATABASE_URL);
    const rows = await sql`SELECT 1 as n, current_database() as db, current_user as usr`;
    cors(res);
    return res.status(200).json({
      ok: true,
      detail: 'Conexão OK',
      debug: { ...debug, queryResult: rows },
    });
  } catch (e) {
    const message = e && e.message ? e.message : String(e);
    const cause = e && e.cause ? (e.cause.message || String(e.cause)) : null;
    cors(res);
    return res.status(200).json({
      ok: false,
      detail: message,
      cause: cause,
      debug,
    });
  }
};
