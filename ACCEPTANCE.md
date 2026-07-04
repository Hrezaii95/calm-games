# The Calm Corner — Acceptance Document

**Binding.** The "Evening Game Room" redesign ships only when every criterion below passes. Pass/fail, no partial credit. Where this conflicts with `DESIGN-SPEC.md` (Google Fonts; emoji glyphs), **this doc wins**: the redesign is fully offline, self-hosted fonts, custom SVG glyphs. Verify on `localhost`, network disconnected.

## 1. Release acceptance criteria

### (a) Offline integrity — zero external requests at runtime
- [ ] Network tab, hard-reload of hub + all 9 games: **0 requests to any non-localhost origin** (fonts, JS, CSS, images, analytics, favicons).
- [ ] No `googleapis`/`gstatic`/CDN (`jsdelivr`, `code.jquery.com`, `cdnjs`)/analytics host in any file. Fonts self-hosted `.woff2`; chess's jQuery/jQuery-UI/Touch-Punch **vendored locally**.
- [ ] Wi-Fi/ethernet off: full site loads, every game plays, no broken glyphs.
- [ ] No `fetch`/`XHR`/`<script src="http...">`/`@import url(http...)` to remote hosts (grep confirms).

### (b) Functionality — all 9 games load and are playable
- [ ] Each loads with **no red console errors** and supports one real interaction:
  mahjong (select a tile) · 2048 (slide once) · memory (flip a pair) · minesweeper (reveal a cell) · word search (select a word) · chess (move a piece) · charades (draw a word) · draw-guess (draw a word) · impostor (deal + step all reveals for 3 players).
- [ ] Lobby control on all 9 returns to `index.html#games`.
- [ ] Hub at 375px width: no horizontal scroll, cards stack, both sections visible.

### (c) Senior accessibility
- [ ] Body text **≥20px**; interactive text ≥17px.
- [ ] Body/secondary text contrast **≥4.5:1** on its background (measure ink and muted on felt-green and on ivory card).
- [ ] Tap targets **≥48px** (primary party-game actions ≥56px).
- [ ] Visible `:focus-visible` outline on every interactive element (keyboard-tab the hub end to end).
- [ ] `prefers-reduced-motion: reduce` disables all transitions/transforms.
- [ ] No timers, sound, or time pressure on by default; nothing color-coded as the sole signal.

### (d) Licensing
- [ ] Each fetched folder retains its upstream `LICENSE`/`COPYING` **untouched** (mahjong, 2048, memory, minesweeper=**GPL-3.0**, wordsearch, chess).
- [ ] Hub Credits + `CREDITS.md` list every game: author link, license, repo, mods noted (Lobby button; chess rename; mahjong base-href; chess libs vendored).
- [ ] GPL-3.0 minesweeper mods noted, source public. Vendored jQuery/etc. keep their own license files.
- [ ] No "Vita" reference; no upstream assets/names/screenshots reused.

### (e) Design quality bar
- [ ] **No emoji glyphs in the hub** — markers are custom SVG (inline or local `.svg`).
- [ ] Design tokens used consistently — no ad-hoc hex, font, or spacing; Fraunces italic display + one accent per game.
- [ ] Solo ("Play on your own") and social ("Play together") sections **visually distinct yet coherent** — shared felt/ivory/gold system, differentiated by eyebrow + accent, not a uniform card wall.
- [ ] Felt-green backdrop, ivory cards, gold accents render as specified on hub and both sections.

## 2. 10-step smoke QA (10 min, localhost)
1. `npx http-server . -p 8080 -c-1`; open `localhost:8080`; DevTools → Network, "Disable cache."
2. **Disconnect network.** Hard-reload hub; Network shows only `localhost`, page fully renders.
3. Keep Network open — assert **0** non-localhost rows across all remaining steps.
4. Keyboard-tab the hub; a visible focus ring moves on every card/button.
5. Resize to 375px: no horizontal scroll, both sections stack.
6. Open mahjong, 2048, memory, minesweeper, word search — each loads clean, one interaction, Lobby back.
7. Chess: board renders offline, move one piece, Lobby back.
8. Charades draw a word; draw-guess draw a word; impostor deal 3 players + step all reveals.
9. Toggle `prefers-reduced-motion: reduce`; animations stop.
10. Color-pick body + muted on felt and on card: ≥4.5:1, body ≥20px.

## 3. Punch-list — 5 most likely failure points
1. **Chess CDN not vendored (CRITICAL).** Plan keeps chess's public-CDN jQuery/jQuery-UI/Touch-Punch — a direct offline fail. Vendor all three, rewrite `<script src>`; board is dead offline otherwise.
2. **Google Fonts still remote (CRITICAL).** Hub has 3 `googleapis`/`gstatic` refs. Self-host fonts as `.woff2` via local `@font-face` or the offline gate fails on load.
3. **Mahjong Angular base-href + service worker (HIGH).** `<base href>` must be `./`; a stale `ngsw-worker`/SW will 404 chunks or hit the network. Fix base-href, strip SW.
4. **Emoji glyphs left in hub (HIGH).** Hub currently uses emoji markers; redesign bans them. Any remaining emoji fails the design bar and can trigger an OS-font lookup.
5. **Contrast on felt-green (MEDIUM).** Muted `#6B675C` + accents were tuned for cream, not deep felt. Re-measure every pair on the dark backdrop; several likely drop below 4.5:1.
