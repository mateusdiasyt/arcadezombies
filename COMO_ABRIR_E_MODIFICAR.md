# Zombie TD Reborn – Como abrir e modificar localmente

Sim: **temos o código fonte decompilado** do jogo (ActionScript 3 + FlashPunk). Não é o projeto original da Adobe Animate, mas dá para editar, estudar e, com um pouco de trabalho, recompilar.

---

## 1. O que temos na pasta

| Pasta / arquivo | Conteúdo |
|-----------------|----------|
| `extracted/scripts/` | **380 arquivos .as** – código do jogo (Main.as é a entrada) |
| `extracted/images/` | Imagens (PNG/JPEG) usadas no jogo |
| `extracted/sounds/` | Sons em MP3 |
| `extracted/fonts/` | Fontes TTF |
| `extracted/shapes/` | Formas vetoriais em SVG |
| `extracted/binaryData/` | Dados dos mapas (.oel) |
| `zombie_td_reborn.swf` | Jogo original (para rodar no Ruffle) |
| `ffdec/` | Ferramenta que usamos para extrair o SWF |

---

## 2. Rodar o jogo localmente (sem modificar código)

Para **só jogar** o SWF no PC:

1. **Ruffle** (emulador de Flash):  
   - Site: https://ruffle.rs  
   - Baixe a versão “Windows” e descompacte.  
   - Arraste `zombie_td_reborn.swf` para o `ruffle.exe` (ou abra pelo menu Arquivo).

2. **Pelo navegador**:  
   - Acesse https://ruffle.rs/demo/  
   - Arraste o arquivo `zombie_td_reborn.swf` para a página.

Assim você abre o jogo localmente sem mexer no código.

---

## 3. Modificar o código

### Onde está o “código fonte”

- Todo o código que você pode editar está em **`extracted/scripts/`**.
- Pode abrir essa pasta no **Cursor / VS Code** (ou outro editor) e editar os `.as`.
- A classe principal é **`Main.as`** (herda de `Engine` do FlashPunk).

### Fluxo de trabalho

1. **Abrir o projeto no editor**  
   - Abra a pasta do jogo no Cursor (File → Open Folder → `zombie td reborn`).
   - Navegue em `extracted/scripts/` para achar as classes (torres, zombies, mundos, etc.).

2. **Fazer as alterações**  
   - Edite os `.as` que quiser (ex.: `Towers.as`, `entities/`, `worlds/GameWorld.as`).

3. **Testar as mudanças**  
   - **Sem recompilar**: continuar usando o **SWF original** no Ruffle só mostra o jogo antigo; as edições nos `.as` **não** aparecem até você recompilar.
   - **Com recompilação**: veja a seção 4 para gerar um novo SWF e testar no Ruffle.

---

## 4. Recompilar (gerar um novo SWF)

Para que as alterações nos `.as` tenham efeito no jogo, é preciso **recompilar** o projeto em SWF.

### O que você precisa

1. **Apache Flex SDK** (compilador `mxmlc` para ActionScript/SWF):  
   - https://flex.apache.org/download-binaries.html  
   - Ou o instalador: https://flex.apache.org/installer.html  

2. **FlashPunk** (engine do jogo):  
   - Código: https://github.com/Draknek/FlashPunk  
   - Você precisa do **código fonte** ou de um **.swc** do FlashPunk no projeto.

3. **Assets na estrutura que o código espera**  
   - O `Assets.as` espera arquivos em **`../assets/`** em relação ao código (ex.: `../assets/title.png`, `../assets/maps/easy.png`, etc.).
   - Na raiz do projeto execute: **`.\preparar_assets.ps1`**  
     Isso cria a pasta **`assets/`** com imagens, fontes e mapas (.oel) copiados de `extracted/` com os nomes que o código espera.

### Sons (Sounds.swf)

- No código, os sons vêm de um **SWF separado**: `../assets/sound/Sounds.swf`.
- Esse arquivo **não** existe no que extraímos (só o SWF principal).
- Você tem duas opções:
  - **Opção A**: Alterar o jogo para carregar os MP3 de `extracted/sounds/` em vez do `Sounds.swf` (ex.: trocar os `[Embed]` por carregamento em tempo de execução).
  - **Opção B**: Tentar extrair/criar um `Sounds.swf` a partir do SWF principal (se existir algo equivalente dentro dele) ou recriar um SWF de sons.

### Exemplo de compilação (depois de configurar Flex + FlashPunk)

Com o Flex no PATH e a pasta `src` apontando para o código (ex.: `extracted/scripts` como raiz de fontes):

```batch
mxmlc -source-path=extracted/scripts ^
      -library-path+=path/to/FlashPunk.swc ^
      -default-size=640 480 ^
      -default-background-color=0x000000 ^
      -output=zombie_td_modificado.swf ^
      extracted/scripts/Main.as
```

Ajuste caminhos e opções conforme sua instalação do Flex e do FlashPunk.

---

## 5. Resumo rápido

| Objetivo | O que fazer |
|----------|-------------|
| **Só jogar** | Usar **Ruffle** e abrir `zombie_td_reborn.swf`. |
| **Só editar código** | Abrir a pasta no Cursor e editar em `extracted/scripts/`. |
| **Ver as mudanças no jogo** | Configurar Flex SDK + FlashPunk, rodar `preparar_assets.ps1`, recompilar e abrir o novo SWF no Ruffle. |

Se quiser, na próxima etapa podemos: (1) montar um projeto de exemplo com `mxmlc` e caminhos certinhos, ou (2) esboçar como trocar os sons do `Sounds.swf` pelos MP3 da pasta `extracted/sounds/`.
