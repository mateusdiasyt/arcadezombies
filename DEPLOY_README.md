# Deploy completo (recompilar + push)

## Script automático

Rode no PowerShell, na pasta do projeto:

```powershell
.\deploy_completo.ps1
```

Ou com mensagem de commit:

```powershell
.\deploy_completo.ps1 "Minha mensagem"
```

O script faz:

1. **Recompilar o SWF** (FFDec: `extracted/scripts` → `zombie_td_reborn_modificado.swf`)
2. **Copiar o SWF** para `public/`
3. **Git add** + **commit**
4. **Git push** (o Vercel faz o deploy automaticamente ao receber o push)

---

## Se o push pedir login/senha

O GitHub **não aceita mais senha** em `git push`. Use um **Personal Access Token (PAT)**:

1. GitHub → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**.
2. **Generate new token**; marque pelo menos **repo**.
3. Copie o token (ele não aparece de novo).
4. No primeiro `git push`, quando pedir:
   - **Username:** seu usuário do GitHub (ex.: `mateusdiasyt`)
   - **Password:** cole o **token** (não a senha da conta).

Para não digitar sempre, configure o Git para guardar a credencial:

```powershell
git config --global credential.helper store
```

Depois do primeiro push com o token, ele será salvo.

---

## O que já foi feito nesta sessão

- SWF **recompilado** (com a alteração no `Main.as` para pular o menu quando `play=1`).
- SWF **copiado** para `public/`.
- **Commit** criado: "Deploy: menu HTML/CSS, game.html, SWF recompilado (pula menu Flash)".
- **Push** não concluído por falta de autenticação (token).

Para publicar: rode `git push` no Git Bash ou no PowerShell (com o token quando pedir) ou configure o PAT uma vez e depois use `.\deploy_completo.ps1` sempre que quiser recompilar e fazer deploy.
