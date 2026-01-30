-- Schema Zombie TD Reborn - contas e PDL
-- Compatível com PostgreSQL (local e Neon).

-- Contas de jogadores
CREATE TABLE IF NOT EXISTS accounts (
  id         SERIAL PRIMARY KEY,
  username   VARCHAR(64) NOT NULL UNIQUE,
  email      VARCHAR(255) UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  pdl        INT NOT NULL DEFAULT 0 CHECK (pdl >= 0 AND pdl <= 3200),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Histórico de partidas (opcional: para ranking e estatísticas)
CREATE TABLE IF NOT EXISTS match_results (
  id         SERIAL PRIMARY KEY,
  account_id INT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  pdl_delta  INT NOT NULL,
  pdl_after  INT NOT NULL,
  win        BOOLEAN NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_match_results_account ON match_results(account_id);
CREATE INDEX IF NOT EXISTS idx_match_results_created ON match_results(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_accounts_pdl ON accounts(pdl DESC);

-- Trigger para atualizar updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS accounts_updated_at ON accounts;
CREATE TRIGGER accounts_updated_at
  BEFORE UPDATE ON accounts
  FOR EACH ROW EXECUTE PROCEDURE set_updated_at();
