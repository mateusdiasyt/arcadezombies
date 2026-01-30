/**
 * Cria as tabelas no banco (local ou Neon).
 * Uso: node scripts/init-db.js
 * Requer DATABASE_URL no .env (ou variável de ambiente).
 */
require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/zombie_td',
});

const schemaPath = path.join(__dirname, '..', 'schema.sql');
let sql = fs.readFileSync(schemaPath, 'utf8');

// Ajuste: EXECUTE PROCEDURE é o nome correto em PostgreSQL para triggers
// (já está assim no schema.sql)

async function init() {
  try {
    await pool.query(sql);
    console.log('Tabelas criadas/atualizadas com sucesso.');
  } catch (e) {
    console.error('Erro ao executar schema:', e.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

init();
