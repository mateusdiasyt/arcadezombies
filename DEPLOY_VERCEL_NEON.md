# Deploy: Vercel + Neon Tech

Jogo (SWF + Ruffle) e API no **Vercel**, banco na **Neon Tech**.

---

## 1. Neon Tech (banco)

1. Crie um projeto em [neon.tech](https://neon.tech) e um banco PostgreSQL.
2. Copie a **connection string** (ex.: `postgresql://user:pass@ep-xxx.region.aws.neon.tech/neondb?sslmode=require`).
3. Rode o schema uma vez no Neon (pode usar o SQL Editor do painel ou o script local com essa URL):
   - Cole o conteúdo de `backend/schema.sql` no SQL Editor do Neon e execute.

---

## 2. Vercel (jogo + API)

1. Conecte o repositório ao [Vercel](https://vercel.com) (Import Project).
2. **Variáveis de ambiente** no projeto Vercel:
   - `DATABASE_URL` = connection string do Neon (a que você copiou).
   - `JWT_SECRET` = uma string longa e aleatória (ex.: gerar com `openssl rand -hex 32`).
3. Deploy: o Vercel vai rodar `npm run build` (que copia o SWF para `public/`) e publicar:
   - **Jogo**: `https://seu-projeto.vercel.app/` (página com Ruffle + SWF).
   - **API**: `https://seu-projeto.vercel.app/api/...` (auth, account, ranking, health).

---

## 3. Endpoints da API (base: `https://seu-projeto.vercel.app`)

| Método | Rota | Descrição |
|--------|------|-----------|
| POST | `/api/auth/register` | Registrar: `{ "username", "email?", "password" }` |
| POST | `/api/auth/login` | Login: `{ "username" ou "email", "password" }` → retorna `token` e `user` |
| GET | `/api/account/me` | Dados do usuário (header: `Authorization: Bearer <token>`) |
| POST | `/api/account/pdl` | Atualizar PDL: `{ "delta": 3 }` vitória, `{ "delta": -2 }` derrota |
| GET | `/api/ranking?limit=50` | Top jogadores por PDL |
| GET | `/api/health` | Health check (e se o banco está ok) |

---

## 4. SWF no deploy

O script `npm run build` copia `zombie_td_reborn_modificado.swf` para `public/`.  
Se você alterar o jogo e gerar um novo SWF, substitua o arquivo na raiz do projeto e faça um novo deploy no Vercel.

---

## 5. CORS

A API já envia `Access-Control-Allow-Origin: *`, então o jogo (ou um front em outro domínio) pode chamar a API. Para produção você pode restringir a origem no Vercel (headers) ou na lógica da API.
