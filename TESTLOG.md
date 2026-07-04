# Test log — Calm Corner

## Pre-verification of bundled pages (advisor, 2026-07-04, local http-server, Chromium)

| Page | Result | Evidence |
|------|--------|----------|
| Hub `/` | PASS | Renders both sections, all 9 cards, credits footer; zero console errors/warnings; semantic structure (banner/main/regions/contentinfo) correct |
| Hub `/` @ 375×812 | PASS | No horizontal scroll; grid collapses to 1 column; card width 327px |
| `games/charades/` | PASS | New-word draw works; category chips filter correctly (Sports-only → drew "Karate"); timer opt-in shows 90s countdown; Lobby pill present; zero console errors |
| `games/draw-guess/` | PASS | New-word draw works; category chips filter correctly (Tricky-only → drew "Winter"); Lobby pill present; zero console errors |
| `games/impostor/` | PASS | Full 3-player round: exactly 1 impostor dealt; other players received the identical word; discussion stage shown after last reveal; impostor reveal correct ("Player 1 … the word was Hospital"); Play-again resets to setup; zero console errors |

Not yet tested (Cursor Phase 3 on target machine): the 6 fetched games (mahjong, 2048, memory, minesweeper, wordsearch, chess) — they don't exist locally until Phase 1 runs. Hub links to them will 404 until then; that is expected.

## Offline vendoring audit (2026-07-04, v2 Evening Game Room build)

**External games fetched:** All 6 games (Mahjong, 2048, Memory Match, Minesweeper, Word Search, Chess) successfully retrieved from upstream repositories.

**Fonts self-hosted:** 7 WOFF2 files embedded in `assets/fonts/` with centralized `fonts.css` stylesheet (Fraunces regular/bold/italic, Nunito regular/semibold).

**CDN scripts vendored:** Chess and Word Search upstream dependencies (jQuery, jQuery UI, Touch Punch, Augment.js) extracted from CDN references and copied into local `vendor/` subdirectories. GitHub ribbon image references removed from Chess game.

**Runtime external-reference audit:** Grep audit of all HTML files found zero external `script src`, `link href`, or `img src` references pointing to runtime-loaded resources. All remaining `https://` occurrences are user-clickable credit hyperlinks in footer/about sections and code comments only.

**Result:** v2 Evening Game Room bundle is fully offline-capable — no runtime network calls required after HTML load.

## v2 localhost QA (advisor as orchestrator, 2026-07-04, http-server :8123, embedded Chromium)

Note: the test tab ran hidden, so `requestAnimationFrame` was paused — games that defer DOM painting to rAF (2048 tiles, chess move-list refresh) were verified at engine level instead; they render normally in a visible browser.

| Page | Result | Evidence |
|------|--------|----------|
| Hub | PASS | 9 cards, self-hosted Fraunces italic rendering (mobile screenshot confirmed felt/brass design); zero console errors; `background-attachment:fixed` removed as scroll-jank/capture risk |
| Mahjong | PASS | Angular app boots from subfolder (`base href="./"`), app-root rendered, zero console errors. Cosmetic: requests `assets/img/.jpg` (empty background setting) → local 404 |
| 2048 | PASS (engine-verified) | All 10 scripts local; GameManager starts with 2 tiles, engine move merged to 4 and scored 4; DOM tiles defer to rAF (hidden-tab artifact) |
| Memory | PASS | Settings modal → Start New Game → 12 cards dealt; first card flips on click |
| Minesweeper | PASS | 81-cell board; vendored jQuery 1.7.2 local; cell click registers |
| Word Search | PASS | 64-letter grid + 21 words generated; vendored jQuery 1.7.1; wordfind lib loaded |
| Chess | PASS (engine-verified) | 64 squares, 32 Unicode pieces, legal-move links (a2-a4 …) respond to clicks; vendored jQuery 1.9.0 + jQuery UI + Touch Punch all local; full move rendering defers to rAF |
| Charades (v2 skin) | PASS | Word draw works post-restyle; 5 chips; local fonts.css linked |
| Draw & Guess / Impostor (v2 skin) | PASS | Restyle agent verified all IDs/scripts untouched; logic fully tested pre-restyle; impostor contrast fixes applied |

**Offline proof (network-level):** full browsing session across hub + all games recorded via DevTools network capture — every request targets `http://localhost:8123` (plus one inline `data:` URI). Zero external hosts contacted.

## v3 "Clay & Ink" redesign QA (2026-07-04)

Mobile (375×812) hub metrics — before (v2) → after (v3): eyebrow 3 lines → **1 line**; page length 5.6 → **4.0 screens**; first game tile at 530px → **364px**; h1 56px → 44px; box-shadows and radial gradients **removed entirely** (flat tinted tiles + 1.5px hairlines); sticky mini-bar added (53px, Solo/Together anchors); normal tiles switch to horizontal layout on phones.

| Check | Result |
|-------|--------|
| Hub v3 structure @375px | PASS — per-tile poster tints applied, bento spans on desktop grid, zero console errors |
| Motion guards | PASS — test browser reports `prefers-reduced-motion: reduce` and correctly receives the static page; engine confirms `linear()` + `animation-timeline: view()` support for motion-enabled browsers; `linear()` spring moved from a custom property into an `@supports` block (IACVT var() trap fixed) |
| Party pages v3 (charades spot-check) | PASS — flat #1E1B18 body, sand word-card, no shadows, word draw works, lobby pill present |
| Fetched games (minesweeper spot-check) | PASS — 81 cells, v3 lobby pill (first time pills exist in fetched games — v2 gap found & fixed), view-transition style injected |
| Offline runtime-reference audit (all 9 + hub) | PASS — zero external script/link/img references |

Restyle agent verified all party-page JS/IDs untouched; two stale inline styles in impostor (referencing deleted v2 vars) fixed.

## Expansion to 27 games (2026-07-05)

18 new games integrated by the 4-agent fleet (3 adopts, 4 of 6 maybes, 8 hunter finds, 3 original party builds). Drops: jigsaw (unlicensed fan-art images upstream), solitaire-xl (no LICENSE file). All 18 new routes verified HTTP 200 on localhost; final offline audit clean (only the conditional Telegram bridge references an external host, and only inside Telegram); solitaire upstream canonical tag removed. Genre gaps with no license-clean candidates: ultimate tic-tac-toe, dominoes.
