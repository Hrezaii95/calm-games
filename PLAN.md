# Calm Corner — 5-game senior-friendly puzzle bundle (beta in <2 hours)

**Date:** 2026-07-04 · **Owner:** hossein · **Status:** ready to execute
**Executor:** Cursor, following `CURSOR-PROMPT.md` literally (no thinking required).

## Honest verdict

A publishable beta bundle in under 2 hours is realistic **only** with this exact scope:

- **5 games, all verified fork-ready** — prebuilt/static, zero npm builds, licenses read off the repos by research agents (2026-07-04).
- **One beautiful custom hub page** ("The Calm Corner") — this is where the "beautiful skin" lives. The games keep their own decent upstream skins plus a floating "⌂ Lobby" button for cohesion.
- **Deep per-game reskin is NOT in the 2-hour scope.** Harmonizing 5 foreign codebases visually is a v1.1 job (see Stretch below). Anyone who tells you otherwise is selling something.
- Publishing: GitHub Pages via `gh` CLI — fully scriptable, zero new accounts, free.

## Game lineup (core — all verified)

| # | Game | Repo | License | How we get it | Demo verified |
|---|------|------|---------|---------------|---------------|
| 1 | Mahjong Solitaire | https://github.com/ffalt/mah | MIT | copy `gh-pages` branch (prebuilt Angular output) | https://ffalt.github.io/mah/ |
| 2 | 2048 (original) | https://github.com/gabrielecirulli/2048 | MIT | clone default branch, serve as-is | http://gabrielecirulli.github.io/2048/ |
| 3 | Memory Match | https://github.com/mmenavas/memory-game | MIT | clone default branch, serve as-is | http://mmenavas.github.io/memory-game |
| 4 | Minesweeper | https://github.com/michaelbutler/minesweeper | **GPL-3.0** | clone default branch, serve as-is | https://michaelbutler.github.io/minesweeper/ |
| 5 | Word Search | https://github.com/bunkat/wordfind | MIT | clone default branch, serve repo demo page | http://Lucas-C.github.com/wordfind/ (fork demo) |

## "Play together" additions (v2 scope, verified 2026-07-04)

| # | Game | Source | License | How we get it |
|---|------|--------|---------|---------------|
| 6 | Chess (2-player, one screen) | https://github.com/kbjorklu/chess | MIT (LICENSE file verified) | clone; rename `chess.html` → `index.html`; keep its CDN script tags (jQuery/jQuery UI/Touch Punch) for the online beta |
| 7 | Charades (pantomime) | **pre-built in this repo** (`games/charades/`) | ours, MIT | nothing — done |
| 8 | Draw & Guess (pictionary-style prompts; players draw on paper) | **pre-built** (`games/draw-guess/`) | ours, MIT | nothing — done |
| 9 | The Impostor (pass-the-phone social deduction) | **pre-built** (`games/impostor/`) | ours, MIT | nothing — done |

Party-game naming hygiene: "Pictionary" is a Mattel trademark → ours is "Draw & Guess". "Charades" is a generic parlor game — safe. Word lists are original.

**Secret Hitler — researched, verdict NO for this bundle:** the official game is licensed CC BY-NC-SA 4.0 (non-commercial, share-alike, explicitly bans app-store distribution), and the main OSS implementation (cozuya/secret-hitler, same CC BY-NC-SA license) requires Node + Socket.IO + MongoDB + Redis — not static-hostable. The Impostor covers the hidden-role niche legally with zero servers. Real-time online social deduction of any kind = servers = out of the free-static model entirely.

**Checkers (backup, not fetched today):** https://github.com/codethejason/checkers — GPL-2.0 verified, static index.html/script.js, demo at codethejason.github.io/checkers. Adopt in v1.1 if wanted; same copyleft handling as minesweeper.

**Pre-built in this folder (do not recreate):** `index.html` (hub, two sections), `DESIGN-SPEC.md` (binding design system — tokens, type, components, a11y), and the three party games above. Cursor only fetches the 6 external games, injects lobby buttons, tests, publishes.

**Dropped after research (don't revisit without new evidence):**
- Card solitaire `rjanjic/js-solitaire` (MIT) — requires an old yarn/babel build; classic time sink. → Stretch.
- Sudoku — best static candidate has an informal license; the MIT alternative (`EduardoProfe666/sudoku-play`) is unverified on build/hosting. → Stretch.
- Jigsaw `medmunds/puzzles` — canvas/Emscripten, unmaintained since 2013, license unconfirmed. → Skip.
- Block puzzle — no decent MIT/Apache static candidate exists. → Skip or custom-build later.
- `lufinkey/web-solitaire` — does not exist (404). Never reference it.
- Chess assembled from chessboardjs + chess.js — libraries only, no ready game; violates the no-assembly rule. kbjorklu/chess adopted instead.
- Unlicensed chess/checkers repos (AhmadAlkholy/Javascript-Chess-Game, niemet0502/checkers-game-js, draughts.github.io and similar `license: null` repos) — no license = no reuse rights. Rejected on principle.

## Licensing / audit position

- Every game folder keeps its upstream `LICENSE` file untouched; hub has a Credits section linking author + license + upstream repo for each game.
- **Minesweeper is GPL-3.0 (copyleft):** fine for this free beta because the whole bundle repo is public on GitHub (source availability satisfied). Our only modification (injected Lobby button) is noted in credits. If you ever monetize or close the source, swap this game out first.
- Mechanics are not copyrightable; we ship zero Vita Games assets, names, or screenshots. Product name "The Calm Corner" is a placeholder — rename freely before any store push.

## Publishing (free only)

- **Primary — GitHub Pages:** public repo `calm-games`, deploy-from-branch `main` `/`, URL `https://<user>.github.io/calm-games/`. Limits: 1 GB site, 100 GB/mo soft bandwidth. Fully scripted in the Cursor prompt via `gh`.
- **Fallback — Cloudflare Pages Direct Upload:** no credit card, unlimited bandwidth, 20k files / 25 MiB-per-file limits, drag-and-drop the folder at dash.cloudflare.com (Workers & Pages → Create → Direct Upload) or `npx wrangler pages deploy . --project-name=calm-games`. Use if GH Pages misbehaves or you want a cleaner `*.pages.dev` URL.
- **Beta feedback:** GitHub Issues link in the hub footer. **Analytics (optional, cookieless, no banner):** GoatCounter free snippet or Cloudflare Web Analytics — placeholders are in the hub HTML, commented out.

## Tests & audits (in scope for 2h)

1. **Smoke test each game locally** (`npx http-server`): loads, zero console errors, one playable move, Lobby button returns to hub. Results logged in `TESTLOG.md`.
2. **Link audit:** every hub card resolves 200 locally and after deploy.
3. **License audit:** each game folder contains upstream LICENSE; credits section lists all 5; modifications noted.
4. **A11y quick pass on hub:** body ≥20px, contrast ≥4.5:1, visible focus states, reduced-motion respected (already baked into the provided CSS).
5. **Post-deploy:** Lighthouse in Chrome DevTools on the hub — expect ≥90 performance/accessibility; note score in `SHIP-REPORT.md`.

## Known risks (with fixes in the prompt)

| Risk | Fix |
|------|-----|
| mah (Angular) breaks in subfolder | Edit `<base href>` → `./` in its built index.html; if chunks still 404, remove service-worker registration. Timebox 15 min, then drop the game and note it. |
| wordfind touch support unknown (jQuery-era) | Acceptable for beta; test on phone; note in SHIP-REPORT. Drop if unplayable. |
| Any game fails its timebox | Drop it, ship the rest. 4 games shipped beats 5 games unshipped. |

## Stretch roadmap (v1.1 — NOT today)

1. Card solitaire: build `rjanjic/js-solitaire` (needs Node; risk of old-toolchain breakage).
2. Sudoku: verify `EduardoProfe666/sudoku-play` (MIT) builds static.
3. PWA installability: `manifest.json` (name, short_name, icons 192+512, display:standalone, start_url) + no-op service worker — Chrome still requires the SW for the install prompt.
4. Unified skin layer per game (shared `skin.css` + palette overrides per repo).
5. itch.io restricted-access page for a private beta circle (1,000-file zip cap — check count first).
6. Rename + custom domain; senior-mode toggles (XL tiles) inside games.

## Sources (verified by subagents 2026-07-04)

- https://github.com/ffalt/mah · https://github.com/gabrielecirulli/2048 · https://github.com/mmenavas/memory-game · https://github.com/michaelbutler/minesweeper · https://github.com/bunkat/wordfind
- https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits
- https://developers.cloudflare.com/pages/platform/limits/ · https://developers.cloudflare.com/pages/get-started/direct-upload/
- https://itch.io/docs/creators/html5 · https://itch.io/docs/creators/access-control
- https://developer.chrome.com/docs/lighthouse/pwa/installable-manifest
- https://www.goatcounter.com/
