# Surface

Codex and Claude Code skills for the experiential surface of web interfaces.

Six focused skills and a shared design philosophy covering motion, interaction design, typography, copy, colour, and platform implementation. Each skill owns a single domain completely, triggering only when its expertise is needed.

Companion to system, which covers naming, tokens, component architecture, and composite UI patterns. Both suites live in the [ui-craft](https://github.com/olzn/ui-craft) repo.

---

## Suite Boundary

**surface defines how interface parts look, read, move, respond, and feel in use.** It is the felt-quality layer: typography, copy, colour, motion, interaction behaviour, platform details, accessibility polish, and visual refinement.

Use **system** when deciding what the interface is made from and how those parts are named, structured, and reused: vocabulary, tokens, component APIs, component composition, and composite patterns.

Rule of thumb: if the question is "how should this render, read, feel, move, or behave in the browser?", start with surface. If the question is "what is this thing, what is it called, and how does it fit into the reusable system?", use system.

---

## The Suite

```
surface/
├── design-philosophy.md        Shared reference. Not a skill.
├── accessibility.md            Accessibility cross-reference across all skills.
├── composition.md              Multi-skill task sequencing and lead-skill lookup.
├── surface-motion/SKILL.md       How to animate.
├── surface-interaction/SKILL.md  Whether and why to animate.
├── surface-typography/SKILL.md         Typography systems.
├── surface-copy/SKILL.md         Interface copy and UX writing.
├── surface-colour/SKILL.md       Colour systems.
└── surface-details/SKILL.md       Platform implementation details.
```

### design-philosophy.md

The shared design voice. Three pillars (Simplicity, Fluidity, Delight), taste principles, and the anti-generic-AI-aesthetic stance. Not a skill with its own trigger. Domain skills reference it when design intent matters.

### accessibility.md

Cross-reference guide for accessibility requirements scattered across all ten domain skills. Covers keyboard navigation, focus management, semantic HTML/ARIA, colour contrast, motion, disabled states, text/selection, and touch. Includes a combined verification checklist.

### composition.md

How the ten domain skills work together. Ordered sequences for common tasks (new project setup, building a page, building a component, design system audit, visual polish pass), a lead-skill lookup table, and guidance on cross-skill boundaries.

Based on the work of [Benji Taylor](https://benji.org/family-values) and [Rauno Freiberg](https://rauno.me).

### surface-motion

Animation implementation. Easing curves (default + reference table, custom over built-in), springs vs bezier, duration limits and scaling, performant properties (`transform`, `opacity`, `filter`), hardware acceleration (WAAPI), scale ranges, `transform-origin` with Radix/Base UI CSS variables, exit patterns (subtle exits, AnimatePresence, `@starting-style`, `initial={false}` for default-state UI), staggered entrances, icon swap animation including CSS-only swaps, paired element timing, blur as transition mask, CSS transitions vs keyframes, scroll reveals (`whileInView`), animation principles for UI (anticipation, follow-through, secondary action, arcs), `prefers-reduced-motion`, debugging by frame review, and recommended libraries.

Sources: [Rauno Freiberg](https://rauno.me), [Jakub Królikowski](https://jakub.kr), [Raphael Salaja](https://www.raphaelsalaja.com/library/12-principles-of-animation), [Emil Kowalski](https://emilkowal.ski)

### surface-interaction

Interaction design decisions. Gesture intent inference (trigger during vs on end), responsive feedback (first-pixel tracking), spatial consistency (expand from trigger, dismiss reverses entry, forward = right), frequency/novelty calibration (when NOT to animate, the 50-use test, keyboard vs touch), staging (one focal animation at a time), kinetic physics (momentum, variable timing, interruptibility), metaphor reuse, and drag design patterns (snap points, velocity-based dismiss, progressive reveal, elastic resistance, pointer capture). Plus web-specific patterns (scroll-snap, IntersectionObserver, `:focus-within`) and perceptual heuristics from Laws of UX.

Sources: [Rauno Freiberg](https://rauno.me/craft/interaction-design), [Jakub Królikowski](https://jakub.kr/work/drag-gesture), [Laws of UX](https://lawsofux.com)

### surface-typography

Typography systems. Modular type scales with named ratios, fixed vs fluid typography (app UIs vs marketing), vertical rhythm and baseline grids, font loading strategy (`font-display: swap` + metric overrides + subsetting + preload + self-host), OpenType features (`kern`, `liga`, `calt`, `tabular-nums`, `oldstyle-nums`), variable font axes and optical sizing, font pairing (the rule of contrast, strategies), and text rendering (`antialiased`, `optimizeLegibility`, `text-wrap: balance`/`pretty` with long-text caveats).

### surface-copy

Interface copy and UX writing. Error message bodies, empty states, helper text, onboarding, tooltip prose, loading text, success and warning messages, confirmation body copy, marketing-style CTAs, tone, localisation notes, and copy reviews. Uses established terminology from system-naming and does not rename product actions or concepts.

### surface-colour

Colour systems built on OKLCH. Why HSL fails, perceptually uniform scale generation with chroma tapering, neutral scales, semantic colour mapping (`--color-{role}-{variant}`), light/dark theme construction (remap semantics, not primitives), accessible contrast (WCAG 2.x AA baseline + APCA secondary check), colour blindness (the "never colour alone" rule, testing for all three types), and wide gamut P3.

Source: [OKLCH.fyi](https://oklch.fyi)

### surface-details

Platform-specific implementation details and visual polish. Forms and inputs (labels, types, decorations, autocomplete), toggles and buttons (dead zones, expanded hit areas, `user-select`, `pointer-events`), dropdowns (`mousedown`, prediction cones), tooltips (delay skipping on subsequent tooltips), touch (`@media (hover: hover)`, iOS 16px zoom, auto-focus, video autoplay, tap highlight, `touch-action`, safe-area insets), scroll (smooth anchors, pause off-screen), performance (`blur()` cost, banding, GPU compositing, `will-change`, React refs for real-time values), accessibility micro-details (disabled tooltips, focus rings, `inert`, arrow keys, `aria-label`, gradient text selection), implementation patterns (optimistic updates, auth redirects, `::selection`, feedback placement, empty states, theme switching, hydration flash, `document.hidden` timer pause, hover gap-fill, pointer capture), and visual polish (concentric border radius, optical alignment, Derek Briggs natural shadow method, hairline separators, image outlines).

Sources: [Rauno Freiberg](https://interfaces.rauno.me), [Jakub Królikowski](https://jakub.kr/writing/details-that-make-interfaces-feel-better), [Emil Kowalski](https://emilkowal.ski/ui/building-a-toast-component), [Derek Briggs](https://x.com/PixelJanitor)

---

## How They Trigger

Each skill fires independently based on the task. They don't fire in bulk on every request.

**"Set up the type system"**: surface-typography fires.

**"This hover is sticky on mobile"**: surface-details fires.

**"Should this modal animate?"**: surface-interaction fires.

**"What easing curve for this entrance?"**: surface-motion fires.

**"Create a colour palette with dark mode"**: surface-colour fires.

**"This empty state copy feels unclear"**: surface-copy fires.

### The motion/interaction seam

surface-interaction says: "This modal should grow from its trigger, be interruptible, and skip animation when opened via keyboard shortcut."

surface-motion says: use `cubic-bezier(0.16, 1, 0.3, 1)` at 250ms on `transform` and `opacity`, `transform-origin` at the trigger position, minimum scale 0.85.

Two different mental modes. One is taste. The other is specification.

---

## Installation

Use the root repository installer:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/ui-craft/main/install.sh | sh
```

Set `TARGET_DIR` to install into a project or Claude Code folder:

```sh
TARGET_DIR=.claude/skills sh install.sh
```

---

## Companion: system

The structural counterpart to this suite. Covers naming, design tokens, component APIs, and composite UI patterns.

**[github.com/olzn/ui-craft/tree/main/system](https://github.com/olzn/ui-craft/tree/main/system)**

---

## Learnings

Each skill includes a `learnings.md` convention. After completing a task with a skill, patterns, edge cases, and library quirks are appended to a `learnings.md` file in that skill's folder. The skill consults this file before starting new tasks.

---

## Licence

MIT
