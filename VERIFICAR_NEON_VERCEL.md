# Erros de conexão Neon no Vercel — Checklist

**"fetch failed"** ou **"getaddrinfo ENOTFOUND ep-summer-truth-..."** = a API no Vercel não consegue conectar à Neon (HTTP ou DNS). Siga os passos abaixo.

---

## 0. Integração Neon + Vercel (recomendado)

Se você configurou a `DATABASE_URL` manualmente e está dando **ENOTFOUND** ou **fetch failed**, use a integração oficial:

1. No **Vercel**: **Settings** → **Integrations** → **Browse Marketplace** → procure **Neon** → **Add Integration** e vincule sua conta Neon e o projeto.
2. Ou no **Neon**: **Console** → seu projeto → **Integrations** → **Vercel** e conecte o projeto arcadezombies.

A integração cria/atualiza a variável de conexão no formato que o Vercel consegue usar. Depois faça **Redeploy**.

---

## 1. DATABASE_URL no Vercel (se não usar integração)

1. Acesse [vercel.com](https://vercel.com) → seu projeto **arcadezombies** → **Settings** → **Environment Variables**.
2. Confirme que existe **`DATABASE_URL`**.
3. **Valor:** copie de novo a **connection string** da Neon (Connect → **Pooled connection**). O host deve ser **inteiro**, por exemplo: `ep-summer-truth-ahz25ymf-pooler.c-3.us-east-1.aws.neon.tech` (sem espaços, sem aspas, uma linha só).
4. **Ambientes:** marque **Production** (e Preview/Development se usar).
5. Salve e faça **Redeploy** (Deployments → ⋮ → Redeploy).

---

## 2. Connection string da Neon (pooled)

No [Neon Console](https://console.neon.tech):

1. Abra seu projeto → **Connect** (ou **Connection details**).
2. Escolha **Pooled connection** (não "Direct").
3. Copie a connection string. Ela deve ter **`-pooler`** no host, por exemplo:
   `ep-summer-truth-ahz25ymf-pooler.xxx.aws.neon.tech`
4. No Vercel, cole **exatamente** essa string em **Value** de `DATABASE_URL` (sem espaços no início/fim, uma linha só).

Exemplo de formato:
```
postgresql://neondb_owner:SENHA@ep-xxx-pooler.xxx.aws.neon.tech/neondb?sslmode=require
```

Se a Neon mostrar `channel_binding=require`, pode incluir: `?sslmode=require&channel_binding=require`.

---

## 3. Projeto Neon ativo

No plano gratuito, o projeto pode **pausar** após um tempo sem uso.

1. Abra o [Neon Console](https://console.neon.tech) e entre no projeto.
2. Se estiver pausado, clique para **retomar** o projeto.
3. Depois teste de novo o registro no site.

---

## 4. Redeploy após mudar variáveis

Sempre que alterar **Environment Variables** no Vercel, é preciso **Redeploy** para as funções usarem o novo valor:

- **Deployments** → no último deploy → **⋮** → **Redeploy**.

---

## Resumo

| Onde        | O que verificar                                      |
|------------|------------------------------------------------------|
| Vercel     | `DATABASE_URL` existe e está preenchida para Production (e outros se usar). |
| Neon       | Connection string é **Pooled**; projeto está ativo (não pausado). |
| Depois     | Redeploy no Vercel após qualquer alteração em env.   |

Se depois disso ainda aparecer "fetch failed", abra o **Vercel** → **Logs** da função (ou **Deployments** → último deploy → **Functions** → log da `/api/auth/register`) e veja se há mais detalhes do erro.
