# Criar tabelas na Neon Tech (uma vez)

Antes de usar login/registro no jogo, crie as tabelas no banco da Neon.

---

## Passo a passo

1. Acesse [console.neon.tech](https://console.neon.tech) e abra seu projeto.
2. No menu lateral, clique em **SQL Editor**.
3. Abra o arquivo **`backend/schema.sql`** deste projeto (no seu PC) e copie **todo** o conteúdo.
4. Cole no editor SQL da Neon e clique em **Run** (ou Execute).

Se aparecer "Success" ou não houver erro, as tabelas **accounts** e **match_results** foram criadas.

---

## Conferir

No SQL Editor da Neon, rode:

```sql
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```

Deve aparecer `accounts` e `match_results`.

Depois disso, o menu do jogo (login/registro) e a API vão funcionar com a Neon.

---

## Recompilar o SWF (pular menu do Flash)

Foi alterado o `Main.as` para que, quando o jogo for aberto pela nossa página (game.html com `play=1`), ele pule o menu do Flash e vá direto para a partida. Para isso valer no SWF que você sobe no Vercel:

1. Recompile o SWF com o FFDec (use o script `compilar_swf.ps1` ou o comando `-importScript` do ffdec).
2. Substitua o arquivo `zombie_td_reborn_modificado.swf` na raiz do projeto pelo novo.
3. Faça commit e push; no próximo deploy o Vercel usará o novo SWF.
