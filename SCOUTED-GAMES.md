# Scouted games — persona fleet report (2026-07-04)

Six persona scouts (3 Sonnet, 3 Haiku) swept distinct genre territories for additions to the bundle. Every repo below was license-verified by actually fetching the repo/LICENSE (candidates without a license file were auto-rejected — and that was the **#1 rejection reason across all genres**; GPL is the realistic license ceiling in casual-game land, MIT is scarcer).

## ADOPT — integrate next (fills a real gap, license-clean, near-zero integration cost)

| Game | Repo | License | Why | Integration notes |
|------|------|---------|-----|-------------------|
| Klondike Solitaire | https://github.com/jhatzimalis/solitaire | MIT (LICENSE verified) | The #1 missing seniors genre; single index.html, DOM cards sized by CSS vars (`--card-w/--card-h` — trivial large-print mode), touch drag + tap-move, live gh-pages demo | Single-file drop-in to `games/solitaire/`; add lobby pill + v3 tile |
| Connect Four | https://github.com/STiago/connect-4 | GPL-3.0 (verified) | Perfect intergenerational 2-player; pure static, DOM/CSS board, live demo | Drop-in; GPL handled same as minesweeper (public source + credits note) |
| 15-Puzzle | https://github.com/krishealty/puzzle | MIT (verified) | Clean brain-training slot; vanilla static, DOM tiles, live demo, built-in image editor | Drop-in; verify touch on device |

## MAYBE — hold, real caveats

| Game | Repo | License | Caveat |
|------|------|---------|--------|
| Backgammon | https://github.com/99fk/backgammon-html | GPL-3.0 | Genre gold for seniors, literally one file — but touch support unconfirmed; hand-test before adopting |
| Sokoban | https://github.com/omerkel/Sokoban | Code MIT / **graphics CC BY-NC-SA** | Non-commercial art clause: fine for this personal bundle, blocks any future monetization unless art is swapped |
| Large-print Solitaire | https://github.com/Glizlack/solitaire | MIT per README (LICENSE file not independently verified) | 0-star unproven; could become the "large print" solitaire variant after manual review |
| Word Scramble | https://github.com/jeskodes/word-scramble | MIT (verified) | Fine but light; filler value only |
| Jigsaw | https://github.com/TranHuuDat2004/games_tools | MIT (verified) | It's a mixed tools collection containing a 3×3 jigsaw — weak quality signal, needs manual look |
| Checkers | https://github.com/codethejason/checkers | GPL-2.0 (verified) | Still the unbeaten genre backup from round 1 |

## SKIP — with reasons (don't revisit without new evidence)

- **Undercover** (MASJV, MIT) — good game, but it IS our Impostor's mechanic; redundant.
- **chor-dakat-babu-pulish** (MIT) — hardcoded 4 players; niche.
- **Simon Says** (imEag, MIT) — twitch-paced speed ramp; fails the no-pressure bar without a retuning pass.
- **War** (nthugon, MIT) — shallow game, touch unconfirmed.
- **Tetris** (jakesgordon) — copyright-only license + reflex pressure.
- **TableGather** — AGPL + Node/Socket server; fails static rule.
- **License-null rejects** (unusable regardless of quality): fchavonet othello, kana/othello-js, sheabunge/mancala (also Grunt build), aminejafur dots-and-boxes, louise-hayes/Hangman, AnBera/BoggleGame, pisimulation/WordChallenge, donadigo/FlowFreeJS, danishmughal/sliding-puzzle, niemet0502/checkers, draughts.github.io.
- **Open gaps** (nothing license-clean found): othello/reversi, mancala, dots-and-boxes, pipes/plumber, tangram, peg solitaire, tower of hanoi, hearts/rummy/crazy-eights, offline trivia with bundled question banks.

## Recommended next batch

Solitaire + Connect Four + 15-Puzzle → bundle grows 9 → 12 games (solo 7 / together 5). Estimated integration: ~30–40 min total (fetch, lobby pill, v3 tiles on hub, offline audit, QA), all patterns already established.
