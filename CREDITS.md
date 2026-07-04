# Credits & Licenses — The Calm Corner

Every game folder retains its upstream LICENSE file. Local modifications are limited to: offline vendoring (CDN scripts/fonts copied into each game's `vendor/` folder with references rewritten), removal of decorative external assets (GitHub ribbons, analytics, App Store badges, PWA service workers), the injected "⌂ Lobby" button, the view-transition style tag, and entry-file renames to `index.html` where noted.

## Quiet puzzles

| Game | Upstream | License | Notable modifications |
|------|----------|---------|----------------------|
| Mahjong | https://github.com/ffalt/mah | MIT | base href → `./`; manifest start_url fixed |
| 2048 | https://github.com/gabrielecirulli/2048 | MIT | lobby button only |
| Memory Match | https://github.com/mmenavas/memory-game | MIT | lobby button only |
| Solitaire | https://github.com/jhatzimalis/solitaire | MIT | lobby button only (single-file game) |
| Minesweeper | https://github.com/michaelbutler/minesweeper | GPL-3.0 | jQuery + ribbon image vendored |
| Word Scramble | https://github.com/jeskodes/word-scramble | MIT | Google Fonts vendored; external background image repointed to bundled asset; decorative Font Awesome kit removed |
| 15-Puzzle | https://github.com/krishealty/puzzle | MIT | repo demo page (`example.html`) used as game root |
| Sokoban | https://github.com/omerkel/Sokoban | code MIT; **graphics CC BY-NC-SA 4.0 (non-commercial)** | `html5/src` used as game root; see `games/sokoban/ART-LICENSE-NOTE.md` — swap art before any monetization |
| Lights Out | https://github.com/alex-berson/lights-out | MIT | PWA service worker + App Store links removed |
| Word Search | https://github.com/bunkat/wordfind | MIT | jQuery vendored |
| Peg Solitaire | https://github.com/alex-berson/solitaire | MIT | PWA service worker + App Store links removed |
| Reversi | https://github.com/alex-berson/reversi | MIT | PWA service worker + App Store links removed |
| Sea Battle | https://github.com/billmei/battleboat | MIT | Open Sans vendored; dead ribbon/Google+ links removed; presented as "Sea Battle" |

## Games for company

| Game | Upstream | License | Notable modifications |
|------|----------|---------|----------------------|
| Chess | https://github.com/kbjorklu/chess | MIT | chess.html → index.html; jQuery/jQuery UI/Touch Punch/Augment vendored; ribbon removed |
| Connect Four | https://github.com/STiago/connect-4 | GPL-3.0 | dead glyphicon @font-face removed; dev/test files dropped |
| Checkers | https://github.com/codethejason/checkers | GPL-2.0 | jQuery + Lato font vendored; external link de-linked |
| Backgammon | https://github.com/99fk/backgammon-html | GPL-3.0 | lobby button only (single-file game) |
| Nine Men's Morris | https://github.com/yadav-rahul/Nine-Mens-Morris | MIT | Montserrat + Roboto Slab vendored |
| Snakes & Ladders | https://github.com/hkasera/snakes-and-ladders | MIT | game.html → index.html; copy corrected to local pass-and-play |
| Yacht Dice | https://github.com/99fk/yahtzee-html | GPL-3.0 | lobby button only (single-file game); presented as "Yacht Dice" |
| Mancala | https://github.com/intel/webapps-mancala | Apache-2.0 | `app/` used as game root (packaging tooling dropped); bundled CC-BY sounds + OFL font retain their in-game attribution screen |
| Charades · Draw & Guess · The Impostor · Categories · Would You Rather · Bingo Caller | original Calm Corner mini-games | MIT | all word lists, prompts, and dilemmas are original content |

## Shared assets

- Fonts: Fraunces and Nunito, self-hosted woff2 — SIL Open Font License 1.1.
- Vendored libraries: jQuery, jQuery UI, jQuery UI Touch Punch, Augment.js (MIT); AngularJS (MIT, bundled upstream in Snakes & Ladders).

## Naming notes

"Sea Battle" and "Yacht Dice" are the traditional public-domain game names; this bundle deliberately avoids trademarked commercial titles. GPL-licensed games are redistributed with full modified source in this public repository, satisfying their source-availability terms.
