# Calm Corner — Design Specification v4.0 · "Kitten Cottage"

Binding for every page. v4 replaces v3's dark Clay & Ink with the owner-approved Kitten Cottage direction (mockup B, 2026-07-05): a warm tea-and-biscuit cottage where every game is a soft, squishy pastel tile, an original kitten mascot lives in the shell, and gentle motion runs through the whole app. Cute lives in shape, color, and motion — never in noise. The senior floor is untouchable.

## 1. Direction

**A cozy kitchen table in a storybook cottage.** Light biscuit-cream paper, rounded-everything, chunky tiles with a pressed-cookie bottom bevel, one hand-drawn kitten with a heartbeat of idle animation. Reference genre: cozy mobile puzzle UI (squishy tiles, candy-soft palettes, mascot warmth). All artwork is original — no third-party illustration.

## 2. Tokens

```css
:root{
  /* Paper */
  --paper:#FBF1E3;        /* page background */
  --paper-deep:#F3E4CE;   /* footer, wells, alt panels */
  --card:#FFFDF7;         /* stage/word cards on party pages */
  /* Ink */
  --ink:#5C4433;          /* primary text ≈7.6:1 on paper */
  --ink-soft:#8A6F5C;     /* secondary ≈4.6:1 — 19px minimum */
  --line:rgba(92,68,51,.14);
  /* Brand */
  --caramel:#C97B52;      /* primary CTA + focus ring */
  --caramel-deep:#9E5A38; /* CTA bevel */
  --on-caramel:#FFF4EA;
  /* Squishy tile pairs: fill / bevel / ink (ink ≥4.5:1 on fill at ≥18px) */
  --biscuit:#F2DBBD;   --biscuit-bv:#D3B48C;   --biscuit-ink:#6E4B20;
  --plum:#E5D3E8;      --plum-bv:#BFA3C4;      --plum-ink:#5C3866;
  --peach:#F5CCB5;     --peach-bv:#D6A184;     --peach-ink:#7E3F20;
  --sage:#CFE0CB;      --sage-bv:#A3BC9E;      --sage-ink:#395231;
  --sky:#CBDCEA;       --sky-bv:#9FB6C9;       --sky-ink:#2F4A61;
  --rose:#F3CDD3;      --rose-bv:#D19FA8;      --rose-ink:#7E3541;

  --r-tile:20px; --r-ui:14px;   /* everything rounder than v3 */
  --bevel:5px;                   /* resting bottom bevel */
  --dur:260ms;
  --display:'Baloo 2', Nunito, "Segoe UI", system-ui, sans-serif;  /* rounded, chunky, friendly */
  --sans:Nunito, "Segoe UI", system-ui, sans-serif;
}
```

Fonts: `assets/fonts/fonts-cute.css` adds self-hosted **Baloo 2** (600, 700, latin woff2, OFL); pages link it AFTER the existing `fonts.css` (Nunito stays the body face). Fraunces is retired from v4 pages but its files remain for anything not yet migrated.

## 3. Typography

| Role | Font | Size | Notes |
|------|------|------|------|
| Display h1 | Baloo 2 700 | `clamp(40px, 9vw, 76px)` | line-height 1.04, --ink |
| Section h2 | Baloo 2 700 | `clamp(26px, 4vw, 38px)` | |
| Tile title | Baloo 2 600 | 24px | tile-ink color |
| Big word (party) | Baloo 2 700 | `clamp(40px, 9vw, 64px)` | --ink on --card |
| Body | Nunito 400 | **≥20px** (secondary ≥19px) | |
| Buttons/chips | Nunito 700 | ≥18px | |
| Eyebrow badge | Nunito 700 | 14px | NOT letterspaced caps — v4 uses a soft pill badge: caramel-tinted bg `rgba(201,123,82,.14)`, --caramel text, radius 999 |

## 4. The mascot (original, mandatory element)

An original kitten drawn as inline SVG line-art-plus-fill: cream body `#F6E7D3`, caramel patches `#E8B583`, `--ink` 2.5px strokes, big head, triangle ears (peach inner), dot eyes, tiny triangle nose, three whiskers per side, curled tail. Variants: **hero** (sitting, ~140px, waving paw), **mini** (head only, ~36px, in the sticky bar), **sleeping** (footer, closed-eye curl). Idle animation (see §6): blink + tail sway + gentle bob. The mascot appears on the hub AND (mini head in the eyebrow area) on every party page — this is the continuity anchor.

## 5. Components

**Sticky bar** — paper bg `rgba(251,241,227,.94)`, 1px `--line` bottom border; mini mascot head + wordmark in Baloo 2; Solo/Together links as soft pills (hover: biscuit fill).

**Squishy tile** (`<a class="tile">`) — fill from a tile pair, `2px solid var(--line)` border PLUS `border-bottom: var(--bevel) solid <pair-bv>`, radius `--r-tile`. Contents: glyph (existing line-art symbols recolored to tile-ink) → Baloo title → 18.5px description in tile-ink at 82% → meta chip (party games; 2px line border, radius 999) → "Play →" in tile-ink 700. Hover: `translateY(-4px) rotate(-.6deg)` + bevel grows to 7px. Active: `translateY(2px)` + bevel shrinks to 2px (the squish). Focus: `outline:3px solid var(--caramel); outline-offset:3px`.

**Buttons** — primary: caramel fill, on-caramel text, radius 999, min-height 56px, bottom bevel `4px solid var(--caramel-deep)`; press = squish (translateY(2px), bevel 1px). Secondary: paper fill, 2px caramel border, --ink text. Chips: card fill, 2px `--line` border, radius 999, min-height 48px; selected = caramel fill + on-caramel + 700.

**Stage/word card (party)** — `--card` fill, `2px solid var(--line)` + `6px` bottom bevel in `--paper-deep`... no: bevel `#E3D2B8`; radius 22px; NO shadows anywhere in v4 (bevels carry all depth).

**Lobby pill (all 27 games, identical)** — `position:fixed;left:16px;bottom:16px;z-index:99999; background:#FBF1E3; color:#5C4433; font:700 17px/1 'Baloo 2',Nunito,system-ui; padding:14px 20px; border:2px solid #C97B52; border-bottom-width:4px; border-radius:999px; text-decoration:none; min-height:48px; display:inline-flex; align-items:center;` text `⌂ Lobby`. No shadow.

**Footer** — `--paper-deep`, sleeping-kitten mini SVG beside the credits heading.

## 6. Motion system ("live" — all inside `@media (prefers-reduced-motion: no-preference)`)

1. **Mascot idle**: blink `@keyframes blink{0%,93%,100%{transform:scaleY(1)}95%,97%{transform:scaleY(.08)}}` 5s infinite on the eye group (transform-origin center); tail sway ±8° 3.5s ease-in-out alternate (origin at tail base); hero mascot bobs ±3px 4s.
2. **Floating décor**: 2–3 tiny original paw-print SVGs in the hero, opacity ≤.18, drifting ±10px over 7–9s, mutually offset.
3. **Tile entrance**: scroll reveal via `animation-timeline: view()` inside `@supports` (pop: opacity 0→1, translateY 14px→0, scale .97→1); no IntersectionObserver.
4. **Squish interactions**: hover lift+tilt, active press per §5 — `transition: transform var(--dur) cubic-bezier(.34,1.56,.64,1), border-bottom-width 120ms ease` (gentle overshoot spring; literal easing value, never via a custom property — the IACVT trap).
5. **Cross-page continuity**: every page keeps `@view-transition{navigation:auto}`; v4 pages additionally define `::view-transition-old(root){animation:vt-out 200ms ease both}` / `::view-transition-new(root){animation:vt-in 260ms ease both}` with `@keyframes vt-out{to{opacity:0;transform:translateY(8px)}}` and `@keyframes vt-in{from{opacity:0;transform:translateY(-8px)}}` — the whole app breathes the same way between pages.
6. Reduced motion ⇒ everything static, instant navigation. No autoplaying sound, no infinite spinners, nothing faster than 120ms.

## 7. Party-page recipe (charades · draw-guess · impostor · categories · would-you-rather · bingo)

Keep ALL JavaScript, IDs, ARIA, and DOM structure untouched — `<style>` block, font links, and existing inline style attributes only. Apply: paper body (flat `--paper`), §5 stage card + chips + buttons, §3 type (Baloo display via fonts-cute.css + fonts.css both linked), eyebrow soft-pill badge, page accent = one tile pair (charades peach, draw-guess plum, impostor biscuit, categories sage, would-you-rather rose, bingo sky), §5 lobby pill, §6 motion items 4–6 (squish + view-transition pair). Timer/word displays in Baloo 2. Mini mascot head SVG (copy from spec §4 reference markup in the hub) beside the eyebrow.

## 8. Accessibility floor (unchanged, non-negotiable)

Body ≥20px; secondary ≥19px; tap targets ≥48px, primary ≥56px; whole-tile tap areas; contrast: ink/paper ≈7.6:1, tile inks on fills ≥4.5:1 (pairs in §2 are pre-checked), on-caramel/caramel ≈4.6:1 at ≥18px bold; visible caramel focus rings everywhere; no info by color alone; timers opt-in; no sound.

## 9. Offline rule (unchanged)

Zero runtime external requests (the conditional Telegram bridge on the hub is the sole, in-Telegram-only exception). Baloo 2 self-hosted. Credit hyperlinks fine.
