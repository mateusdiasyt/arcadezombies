const { Pool } = require('pg');

const pool = process.env.DATABASE_URL
  ? new Pool({
      connectionString: process.env.DATABASE_URL,
      ssl: process.env.DATABASE_URL.includes('neon.tech') ? { rejectUnauthorized: true } : false,
      max: 2,
    })
  : null;

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

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
}

function json(res, status, data) {
  cors(res);
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.status(status).json(data);
}

module.exports = { pool, getRankFromPDL, PDL_MIN, PDL_MAX, cors, json };
