# Push para o GitHub (arcadezombies)

Siga estes passos no **Git Bash** ou no terminal onde o **Git** está instalado.

---

## 1. Abrir a pasta do projeto

```bash
cd "C:\Users\PC 01\Desktop\zombie td reborn"
```

---

## 2. Inicializar o repositório (se ainda não tiver)

```bash
git init
```

---

## 3. Adicionar o remote do GitHub

```bash
git remote add origin https://github.com/mateusdiasyt/arcadezombies.git
```

Se já existir um `origin`, troque por:

```bash
git remote set-url origin https://github.com/mateusdiasyt/arcadezombies.git
```

---

## 4. Adicionar arquivos, commitar e enviar

```bash
git add .
git status
git commit -m "Zombie TD Reborn: jogo + API (Vercel + Neon)"
git branch -M main
git push -u origin main
```

Na primeira vez o GitHub pode pedir **usuário e senha**. Use seu usuário do GitHub e, como senha, um **Personal Access Token** (em GitHub → Settings → Developer settings → Personal access tokens).

---

## 5. Deploy no Vercel

1. Acesse [vercel.com](https://vercel.com) e faça login.
2. **Add New** → **Project** → importe o repositório **mateusdiasyt/arcadezombies**.
3. Em **Environment Variables** adicione:
   - `DATABASE_URL` = connection string da Neon
   - `JWT_SECRET` = uma string aleatória longa
4. Clique em **Deploy**.

O jogo ficará em `https://arcadezombies.vercel.app` (ou o nome que o Vercel gerar).

---

## Observação

O arquivo **.gitignore** já está configurado para não enviar `node_modules/` nem `.env`. Nunca commite a connection string da Neon no repositório.
