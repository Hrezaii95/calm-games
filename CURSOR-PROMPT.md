# EXECUTE: Calm Corner game bundle — beta live in <2 hours

You are executing a pre-decided plan. **Do not redesign, do not add dependencies, do not fetch any repo not listed here.** Work phases in order. Every phase has a timebox; if a step exceeds it, apply its stated fallback and move on. Log every deviation, drop, and test result as you go. Shell = Windows PowerShell. Work in THIS folder (`calm-games`) as project root; the repo root IS the website root.

**ALREADY BUILT — do not recreate or restyle:**
- `index.html` (the hub), `DESIGN-SPEC.md` (binding design rules), and three finished party games: `games/charades/`, `games/draw-guess/`, `games/impostor/`.
- Your only permitted edits to these files: remove hub cards/credits for games you drop, and replace `__ISSUES_URL__` in Phase 4.

**Hard rules**
1. Never delete or edit any upstream `LICENSE`/`COPYING` file.
2. Only modifications allowed inside FETCHED game folders: the `<base href>` fix (mahjong), renaming `chess.html` → `index.html` (chess), and appending the Lobby-button snippet before `</body>`.
3. If a game fails its timebox: delete its folder, remove its hub card + credits line, note it in `SHIP-REPORT.md`, continue.
4. Do not mention "Vita" anywhere in the product.
5. Anything visual you must touch follows `DESIGN-SPEC.md` tokens exactly.

---

## Phase 0 — Preflight (5 min)

```powershell
git --version; node --version; gh auth status
mkdir temp -ErrorAction SilentlyContinue
"temp/" | Out-File -Encoding utf8 .gitignore
New-Item -ItemType File -Name ".nojekyll" -Force
```
If `gh auth status` fails → run `gh auth login` (browser flow) before Phase 4; everything else proceeds.

## Phase 1 — Fetch the 6 games (35 min total; 15-min timebox each before fallback)

**1. Mahjong (prebuilt gh-pages branch):**
```powershell
git clone --depth 1 --branch gh-pages https://github.com/ffalt/mah temp/mah
Remove-Item -Recurse -Force temp/mah/.git
Copy-Item -Recurse temp/mah games/mahjong
Invoke-WebRequest https://raw.githubusercontent.com/ffalt/mah/HEAD/LICENSE -OutFile games/mahjong/LICENSE
```
Then open `games/mahjong/index.html` and change the `<base href="...">` tag (whatever its current value) to `<base href="./">`.
*Fallback if the game later 404s its JS chunks when served:* also remove any `navigator.serviceWorker.register(...)` line / `ngsw-worker` reference in index.html. Still broken after 15 min → drop per hard rule 3.

**2. 2048:**
```powershell
git clone --depth 1 https://github.com/gabrielecirulli/2048 temp/2048
Remove-Item -Recurse -Force temp/2048/.git
Copy-Item -Recurse temp/2048 games/2048
```

**3. Memory Match:** same pattern, `https://github.com/mmenavas/memory-game` → `games/memory`

**4. Minesweeper:** same pattern, `https://github.com/michaelbutler/minesweeper` → `games/minesweeper`

**5. Word Search:** same pattern, `https://github.com/bunkat/wordfind` → `games/wordsearch`. Confirm `games/wordsearch/index.html` exists (repo root demo page). If it doesn't exist or the grid doesn't render/select with a mouse when tested in Phase 3 → drop per hard rule 3.

**6. Chess:** same pattern, `https://github.com/kbjorklu/chess` → `games/chess`, then:
```powershell
Rename-Item games/chess/chess.html index.html
```
Note: this game loads jQuery / jQuery UI / Touch Punch from public CDNs — that is ACCEPTED for the beta (site is online-only anyway). Do NOT vendor the libraries today. If the board doesn't render in Phase 3 within 15 min → drop per hard rule 3.

## Phase 2 — Cohesion layer (15 min)

**2a. Lobby button — append EXACTLY this line immediately before `</body>` in the `index.html` of each of the 6 FETCHED games** (mahjong, 2048, memory, minesweeper, wordsearch, chess — the three party games already have it):

```html
<a href="../../index.html#games" style="position:fixed;left:16px;bottom:16px;z-index:99999;background:#2B2A26;color:#F7F2E9;font:700 17px/1 system-ui;padding:14px 18px;border-radius:999px;text-decoration:none;box-shadow:0 3px 12px rgba(0,0,0,.35)">⌂ Lobby</a>
```

**2b.** Create `CREDITS.md` mirroring the hub footer credits list (game, author link, license, modifications: "added lobby button", plus "renamed chess.html to index.html" for chess and "base href changed" for mahjong).

## Phase 3 — Local test (20 min)

```powershell
npx --yes http-server . -p 8080 -c-1
```
Open `http://localhost:8080/` in a browser. For the hub AND all 9 games, verify and record in `TESTLOG.md`:
- Page loads; browser console has no red errors.
- One playable interaction works: select a tile / slide once / flip a card / click a cell / select a word / move a pawn / draw a new charades word / draw a new draw-guess word / deal impostor roles for 3 players and step through all reveals.
- ⌂ Lobby button visible and returns to hub.
- Hub at 375px width (DevTools device mode): no horizontal scroll, cards stack, both sections visible.

Any game failing after its 15-min fix budget → hard rule 3. Then stop the server.

## Phase 4 — Publish to GitHub Pages (15 min)

```powershell
Remove-Item -Recurse -Force temp
git init -b main
git add -A
git commit -m "feat: Calm Corner v0.1 beta - 9-game bundle"
gh repo create calm-games --public --source . --push
$owner = gh api user --jq .login
gh api -X POST "repos/$owner/calm-games/pages" -f "source[branch]=main" -f "source[path]=/" -f build_type=legacy
```
- Replace `__ISSUES_URL__` in `index.html` with `https://github.com/<owner>/calm-games/issues`, then commit & push again.
- If the `gh api ... pages` call errors → enable manually: repo → Settings → Pages → Deploy from a branch → `main` / `/ (root)`.
- Wait ~2 min, then verify `https://<owner>.github.io/calm-games/` and click into every game.
- **Fallback host (only if GH Pages fails):** `npx wrangler pages deploy . --project-name=calm-games` after `npx wrangler login`, or drag-and-drop the folder at dash.cloudflare.com → Workers & Pages → Create → Direct Upload.

## Phase 5 — Audit + ship report (10 min)

Create `SHIP-REPORT.md` containing:
1. Live URL + date/time.
2. Games shipped / dropped (with reasons).
3. TESTLOG summary (pass/fail per game, local + live).
4. License audit confirmation: every fetched game folder has its LICENSE; hub credits complete; minesweeper GPL note present; chess CDN dependencies noted.
5. Lighthouse scores for the hub (Chrome DevTools → Lighthouse → mobile): record performance + accessibility. Don't chase scores today; just record.
6. Deviations from this prompt.

**Definition of done:** live public URL, ≥7 playable games (3 party games are pre-built and must all pass), credits complete, SHIP-REPORT.md written. STOP after this — the stretch items in PLAN.md are explicitly out of scope for this run.
