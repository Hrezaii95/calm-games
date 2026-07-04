# Calm Corner — Design Specification v3.0 · "Clay & Ink"

Binding for every page. v3 replaces v2's "Evening Game Room" after research verdict: v2's heavy shadows (`0 18px 40px rgba(0,0,0,.38)`), brass inlay double-frames, and ambient radial "lamplight" gradients are dated skeuomorphism — the root of the "2000s page" complaint. v3 is **flat, tactile, poster-driven**: near-black warm ink, each game as its own tinted poster tile, crisp hairline borders, zero decorative gradients, modern zero-KB motion. Senior floor unchanged and non-negotiable.

## 1. Direction

Think **App Store feature tiles, printed on craft paper**. Flat tinted surfaces, one crisp border, large line-art glyph as the poster art, generous type. Variety comes from per-game surface tints — no two adjacent tiles the same color. NO box-shadows anywhere. NO radial/ambient gradients. NO double frames, pips, or vignettes. Motion is physical and brief (spring lift, scroll reveal, page cross-fade).

## 2. Tokens

```css
:root{
  --bg:#1E1B18;            /* page — near-black warm ink */
  --bar:rgba(30,27,24,.92);/* sticky bar */
  --text:#F0E9DE;          /* primary on dark ≈12:1 */
  --muted:#A89F91;         /* secondary on dark ≈6.5:1 — 19px minimum */
  --line:rgba(240,233,222,.14);       /* resting borders */
  --line-strong:rgba(240,233,222,.34);/* hover/focus borders */
  --clay:#C96442;          /* brand accent (links, flourish, selected) */
  --sand:#FBF7F0;          /* light surface — used SPARINGLY (buttons, big word cards) */
  --ink-on-sand:#26221E;

  /* Per-game poster tiles: --tile (flat surface tint) + --art (glyph & go-line color) */
  /* mahjong  */ --t-mahjong:#2A342E; --a-mahjong:#9FBFA8;
  /* 2048     */ --t-2048:#33291F;   --a-2048:#D9A441;
  /* memory   */ --t-memory:#2F2530; --a-memory:#C49BB8;
  /* mines    */ --t-mines:#222B33;  --a-mines:#8FB0C9;
  /* words    */ --t-words:#342620;  --a-words:#D98E5F;
  /* chess    */ --t-chess:#282833;  --a-chess:#A9A9CE;
  /* charades */ --t-char:#362320;   --a-char:#D97B62;
  /* draw     */ --t-draw:#2C2431;   --a-draw:#BB93C9;
  /* impostor */ --t-imp:#322B1D;    --a-imp:#D4B45A;

  --r-tile:14px; --r-ui:8px;          /* mixed radius: tiles soft, controls sharper */
  --spring:linear(0, 0.006, 0.025 2.8%, 0.101 6.1%, 0.539 18.9%, 0.721 25.3%, 0.849 31.5%,
    0.937 38.1%, 0.968 41.8%, 0.991 45.7%, 1.006 50.1%, 1.015 55%, 1.017 63.9%, 1.001);
  --dur:280ms;
  --serif:Fraunces,"Palatino Linotype","Book Antiqua",Georgia,serif;
  --sans:Nunito,"Segoe UI",system-ui,sans-serif;
}
```

Body background is FLAT `var(--bg)`. Nothing else.

## 3. Typography (self-hosted, offline)

`assets/fonts/fonts.css` + **preload the display font**: `<link rel="preload" href="assets/fonts/fraunces-700italic.woff2" as="font" type="font/woff2" crossorigin>` (the h1 is the LCP element).

| Role | Font | Size | Notes |
|------|------|------|-------|
| Display h1 | serif italic 700 | `clamp(44px, 11vw, 96px)` | line-height .96, --text |
| Section h2 | serif italic 600 | `clamp(28px, 4vw, 40px)` | |
| Tile title | serif 600 upright | 26px | --text |
| Big word (party) | serif italic 700 | `clamp(42px, 9vw, 68px)` | --ink-on-sand on --sand |
| Lead | sans 400 | `clamp(19px, 2.2vw, 22px)` | --muted, max 52ch |
| Body | sans 400 | **≥20px** primary / ≥19px muted | |
| Tile description | sans 400 | 19px | rgba(240,233,222,.75) on tile tints |
| Eyebrow | sans 700 | 13px caps, .16em tracking | --clay — MUST fit ONE line at 375px |
| Meta chip | sans 600 | 16px | |

## 4. Layout

**Sticky mini-bar** (mobile + desktop): 52px tall, `position:sticky; top:0`, `background:var(--bar)`, `border-bottom:1px solid var(--line)`. Left: wordmark "Calm Corner" (serif italic 20px). Right: two anchor links "Solo · Together" (sans 600 16px, 48px tap height). No blur, no shadow.

**Hero** (compact on phone): padding 56px→24px top on mobile. Eyebrow ONE line ("WORKS OFFLINE · NO ADS"). h1. Clay flourish SVG (2px stroke, --clay). Lead ≤2 lines mobile.

**Tile grid**: desktop `grid-template-columns:repeat(6,1fr)`, gap 18px; featured tile spans 3 cols, normal tiles span 2 (Solo: 1 featured + 4 normal = balanced bento; Together: 1 featured + 3 normal). Mobile (≤640px): single column, gap 14px; **normal tiles switch to horizontal layout** (glyph block 96px square left, text right, min-height 128px) so the page shrinks from 5.6 to ~3.5 screens; featured tiles stay vertical posters (glyph 88px, min-height 240px).

**Tile anatomy** (`<a class="tile">`): flat `background:var(--tile)`, `border:1.5px solid var(--line)`, `border-radius:var(--r-tile)`, padding 22px. Glyph (line-art SVG, stroke 2.5, color --art; 96px featured / 64px normal desktop). Title → 19px description → meta chip (together only; 1.5px border --line, radius --r-ui) → `.go` ("Play →", sans 700 18px, color --art, margin-top:auto). Whole tile is the tap target.

**Hover/active** (fine pointers): `transform:translateY(-4px)`; `transition:transform var(--dur) var(--spring), border-color 160ms ease, background 160ms ease`; border-color→--line-strong; background lightens ~4% (pre-computed hover tint per tile is unnecessary — use `filter:brightness(1.12)` NO — filter repaints; instead overlay `::after{inset:0;background:rgba(240,233,222,.04);opacity:0;transition:opacity 160ms}` → opacity 1 on hover; compositor-only). Active: translateY(-1px). **No box-shadow, ever.**

**Focus**: `outline:3px solid var(--clay); outline-offset:3px` on every interactive element.

**Footer**: flat --bg, `border-top:1px solid var(--line)`, credits 17px --muted, links underlined --text, feedback button = sand pill (`--sand` bg, --ink-on-sand text, radius 999, min-height 56px).

## 5. Motion (zero-KB, all guarded)

1. **Scroll reveal**: `@supports (animation-timeline: view()){ .tile{ animation: reveal linear both; animation-timeline: view(); animation-range: entry 0% entry 55%; } @keyframes reveal{ from{opacity:0; transform:translateY(16px) scale(.985)} to{opacity:1; transform:none} } }` — no IntersectionObserver, silent no-op on old Safari/Firefox mobile.
2. **Cross-page transitions**: `@view-transition{ navigation:auto }` on the hub AND every game page (party pages natively; fetched games get a tiny injected `<style>` block). Degrades to instant nav where unsupported.
3. **Spring hover** via `--spring` linear() easing (transform only).
4. ALL of the above inside `@media (prefers-reduced-motion: no-preference)`. Reduced motion ⇒ static page, instant nav.

## 6. Accessibility floor (unchanged)

Body ≥20px (muted ≥19px); tap targets ≥48px, primary ≥56px; whole-tile tap areas; contrast: --text/--bg ≈12:1, --muted/--bg ≈6.5:1, tile titles ≥9:1 on all tints, --art colors ≥3:1 on their tints (graphics) and ≥4.5:1 where used as text ("Play →" at 18px bold — verified per pair); focus visible everywhere; no info by color alone; timers opt-in; no sound.

## 7. Party-page recipe (charades / draw-guess / impostor)

Keep ALL JS/IDs/DOM untouched. Flat --bg body (REMOVE v2 radial gradients). Stage/word cards: `--sand` surface, `--ink-on-sand` text, 1.5px --line-strong border, radius --r-tile, NO shadow, NO ::before inlay frame. Chips: 1.5px --line border, --text, radius --r-ui, min-height 48px; selected = --clay bg, white text (#FFF7F2), 700. Primary buttons: --sand bg pill? NO — primary = --clay bg, #FFF7F2 text, radius 999, min-height 56px; hover brightness via ::after overlay technique. Secondary: transparent, 1.5px --line-strong border, --text. Page accents: charades --a-char, draw-guess --a-draw, impostor --a-imp (eyebrow + timer color). h1 serif italic --text. Add `@view-transition{navigation:auto}`. Lobby pill per §8.

## 8. Lobby pill (all 9 games, identical)

`position:fixed; left:16px; bottom:16px; z-index:99999; background:rgba(30,27,24,.92); color:#F0E9DE; border:1.5px solid rgba(240,233,222,.34); font:700 17px/1 system-ui; padding:14px 18px; border-radius:999px; text-decoration:none; min-height:48px; display:inline-flex; align-items:center;` — NO shadow. Text: `⌂ Lobby`.

## 9. Offline rule (unchanged)

Zero runtime external requests. Self-hosted fonts only. Vendored libs stay. Clickable credit hyperlinks allowed.
