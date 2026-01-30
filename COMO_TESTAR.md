# Como testar o jogo modificado

## SWF gerado

O arquivo **`zombie_td_reborn_modificado.swf`** foi criado com as alterações de elos e PDL. É esse arquivo que você deve usar para testar (e não o `zombie_td_reborn.swf` original).

---

## Abrir com Ruffle (recomendado)

1. **Baixar o Ruffle** (emulador de Flash):
   - Acesse: **https://ruffle.rs/downloads**
   - Em "Standalone", baixe **Windows (64-bit)** (ZIP).

2. **Extrair e abrir**:
   - Extraia o ZIP em uma pasta.
   - Execute **`ruffle.exe`**.
   - No Ruffle: **File → Open** (ou arraste o arquivo para a janela).
   - Selecione **`zombie_td_reborn_modificado.swf`** (na pasta do projeto).

3. **Testar**:
   - O menu deve mostrar **Iniciar partida**, **Ranking** e **Créditos**.
   - **Iniciar partida** inicia o jogo na dificuldade do seu elo (PDL).
   - **Ranking** mostra seu PDL e elo atual.
   - Ao ganhar: +3 PDL; ao perder: −2 PDL (persistido entre sessões).

---

## Recompilar depois de editar o código

Sempre que alterar arquivos em **`extracted\scripts\`**, rode de novo o script para gerar um novo SWF:

```powershell
.\compilar_swf.ps1
```

Isso regera **`zombie_td_reborn_modificado.swf`**. Abra de novo no Ruffle para testar.

---

## Resumo

| Arquivo | Uso |
|--------|-----|
| `zombie_td_reborn.swf` | Original (sem alterações). |
| `zombie_td_reborn_modificado.swf` | Versão com elos/PDL – use este para testar. |
| `compilar_swf.ps1` | Gera de novo o SWF modificado após editar os `.as`. |
