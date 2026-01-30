# Sistema de Elos e PDL – Zombie TD Reborn

Resumo das alterações feitas no código extraído para substituir **dificuldades** por **elos** e **ranking com PDL**.

---

## Menu inicial

- **Iniciar partida** – inicia o jogo na dificuldade do seu elo atual (derivado do PDL).
- **Ranking** – abre a tela de ranking (PDL atual e nome do elo).
- **Créditos** – igual ao anterior.

Não há mais tela de escolha de dificuldade: o elo é definido pelo PDL.

---

## Elos e faixas de PDL

| Elo     | PDL      | Multiplicador de dificuldade |
|---------|----------|------------------------------|
| Bronze  | 0–100    | 1×                           |
| Prata   | 100–200  | 2×                           |
| Ouro    | 200–400  | 4×                           |
| Platina | 400–800  | 8×                           |
| Diamante| 800–1600 | 16×                          |
| Mestre  | 1600–3200| 32×                          |

- **Ganhar partida:** +3 PDL (persistido).
- **Perder partida:** −2 PDL (mínimo 0).

PDL é salvo em **SharedObject** (`zombie_td_pdl`), ou seja, persiste entre sessões no mesmo navegador/máquina.

---

## Onde foi alterado no código

1. **Const.as** – Constantes dos elos (BRONZE..MASTER), `getDifficultyMultiplierForRank()`, `getRankFromPDL()`, `getMapNameForRank()`.
2. **Globals.as** – `pdl`, `rank`, `loadPDL()`, `addPDL()`, `updateRankFromPDL()`, `showRankingWorld()`, persistência em SharedObject.
3. **Localizer.as** – Textos: `start_iniciar_partida`, `start_ranking`, `ranking_*`, `rank_bronze`..`rank_master`, `pdl_ganhou`, `pdl_perdeu`.
4. **StartWorld.as** – Três botões: Iniciar partida, Ranking, Créditos (todos `GenericButton`). Iniciar partida chama `Globals.showGameWorld()` (sem tela de dificuldade).
5. **RankingWorld.as** (novo) – Exibe PDL e elo atual e botão Voltar para o menu.
6. **GameWorld.as** – Mapa e música escolhidos por `Globals.rank` (via `Const.getMapNameForRank()`).
7. **SpawnEntity.as** – Escolha de waves (EasySpawns / NormalSpawns / HardSpawns / InsaneSpawns) por `Globals.rank`.
8. **Wave.as** – Multiplicador de dificuldade aplicado ao `modifier` dos zombies: `modifier * Const.getDifficultyMultiplierForRank(Globals.rank)`.
9. **Score.as** – Dinheiro inicial por elo (Bronze 70 até Mestre 40).
10. **TowerEntity.as** / **TowerMenu.as** – Percentual de venda da torre por elo (90% Bronze até 65% Mestre).
11. **YouWinWindow.as** – Chama `Globals.addPDL(3)`, exibe “+3 PDL”.
12. **GameOverWindow.as** – Chama `Globals.addPDL(-2)`, exibe “−2 PDL”.
13. **GenericButton.as** – Propriedade `suppressed` e método `reset()` para animação do menu.
14. **Main.as** – `Globals.loadPDL()` no `init()`.

---

## Próximos passos (multiplayer / backend)

O PDL está **só local** (SharedObject). Para ranking multiplayer real:

- Enviar PDL/vitórias/derrotas para um servidor após cada partida.
- Buscar ranking global na tela **Ranking** (lista de jogadores por PDL).
- Opcional: autenticação (login) para associar PDL ao usuário.

Isso exigiria um backend (API) e alterações em `Globals.addPDL()`, `loadPDL()` e em **RankingWorld** para exibir a lista vinda do servidor.
