# API Zombie TD Reborn – Contas e PDL

API local para contas e ranking (PDL). Schema em PostgreSQL, compatível com **Neon Tech** depois.

## Pré-requisitos

- Node.js 18+
- PostgreSQL (local ou Docker)

## Banco local com Docker

```bash
docker run -d --name zombie_td_db -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=zombie_td postgres:16
```

## Configuração

1. Copie o exemplo de ambiente:
   ```bash
   cp .env.example .env
   ```
2. Ajuste `DATABASE_URL` no `.env` se precisar (usuário/senha/porta).

## Criar tabelas

```bash
npm install
npm run db:init
```

Isso executa o `schema.sql` no banco.

## Rodar a API

```bash
npm start
```

A API sobe em `http://localhost:3000` (ou em `PORT` do `.env`).

## Endpoints

| Método | Rota | Descrição |
|--------|------|-----------|
| POST | `/auth/register` | Registrar: `{ "username", "email?", "password" }` |
| POST | `/auth/login` | Login: `{ "username" ou "email", "password" }` → retorna `token` e `user` |
| GET | `/account/me` | Dados do usuário (header: `Authorization: Bearer <token>`) |
| POST | `/account/pdl` | Atualizar PDL: `{ "delta": 3 }` vitória, `{ "delta": -2 }` derrota |
| GET | `/ranking?limit=50` | Top jogadores por PDL |
| GET | `/health` | Health check |

## Usar na Neon

1. Crie um projeto no [Neon](https://neon.tech).
2. Copie a connection string e defina no `.env`:
   ```env
   DATABASE_URL=postgresql://user:pass@ep-xxx.region.aws.neon.tech/neondb?sslmode=require
   ```
3. Rode `npm run db:init` uma vez para criar as tabelas.
4. A API continua igual; apenas a conexão passa a ser na nuvem.

## Próximo passo no jogo (Flash/AS3)

Quando quiser ligar o jogo a esta API:

- Na tela de **login/registro** (a criar): enviar credenciais para `/auth/login` ou `/auth/register` e guardar o `token`.
- Ao **carregar o jogo**: chamar `GET /account/me` com o token e preencher `Globals.pdl` (e eventualmente `Globals.userId`).
- Ao **fim da partida**: em vez de só `Globals.addPDL(±x)` local, fazer também `POST /account/pdl` com `{ "delta": 3 }` ou `-2` e o header `Authorization: Bearer <token>`.
- Na tela **Ranking**: buscar `GET /ranking` e exibir a lista.

Enquanto não houver login no jogo, o PDL continua só local (SharedObject), como está hoje.
