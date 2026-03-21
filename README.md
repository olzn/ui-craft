# UI Craft

Claude Code skills for building web interfaces with uncommon care.

Five focused skills and a shared design philosophy covering motion, interaction design, typography, colour, and platform implementation. Each skill owns a single domain completely, triggering only when its expertise is needed.

Companion to [system-craft](https://github.com/olzn/system-craft), which covers tokens, component architecture, and composite UI patterns.

---

## The Suite

```
ui-craft/
├── design-philosophy.md        Shared reference. Not a skill.
├── accessibility.md            Accessibility cross-reference across all skills.
├── composition.md              Multi-skill task sequencing and lead-skill lookup.
├── motion-craft/SKILL.md       How to animate.
├── interaction-craft/SKILL.md  Whether and why to animate.
├── type-craft/SKILL.md         Typography systems.
├── colour-craft/SKILL.md       Colour systems.
└── detail-craft/SKILL.md       Platform implementation details.
```

### design-philosophy.md

The shared design voice. Three pillars (Simplicity, Fluidity, Delight), taste principles, and the anti-generic-AI-aesthetic stance. Not a skill with its own trigger. Domain skills reference it when design intent matters.

Based on the work of [Benji Taylor](https://benji.org/family-values) and [Rauno Freiberg](https://rauno.me).

### accessibility.md

Cross-reference guide for accessibility requirements scattered across all eight skills. Covers keyboard navigation, focus management, semantic HTML/ARIA, colour contrast, motion, disabled states, text/selection, and touch. Includes a combined verification checklist.

### composition.md

How the eight skills work together. Ordered sequences for common tasks (new project setup, building a page, building a component, design system audit, visual polish pass), a lead-skill lookup table, and guidance on cross-skill boundaries.

### motion-craft

Animation implementation. Easing curves (default + reference table, custom over built-in), springs vs bezier, duration limits and scaling, performant properties (`transform`, `opacity`, `filter`), hardware acceleration (WAAPI), scale ranges, `transform-origin` with Radix/Base UI CSS variables, exit patterns (subtle exits, AnimatePresence, `@starting-style`), staggered entrances, icon swap animation, blur as transition mask, CSS transitions vs keyframes, scroll reveals (`whileInView`), animation principles for UI (anticipation, follow-through, secondary action, arcs), `prefers-reduced-motion`, and recommended libraries.

Sources: [Rauno Freiberg](https://rauno.me), [Jakub Królikowski](https://jakub.kr), [Raphael Salaja](https://www.raphaelsalaja.com/library/12-principles-of-animation), [Emil Kowalski](https://emilkowal.ski)

### interaction-craft

Interaction design decisions. Gesture intent inference (trigger during vs on end), responsive feedback (first-pixel tracking), spatial consistency (expand from trigger, dismiss reverses entry, forward = right), frequency/novelty calibration (when NOT to animate, the 50-use test, keyboard vs touch), staging (one focal animation at a time), kinetic physics (momentum, variable timing, interruptibility), metaphor reuse, and drag design patterns (snap points, velocity-based dismiss, progressive reveal, elastic resistance, pointer capture). Plus web-specific patterns (scroll-snap, IntersectionObserver, `:focus-within`) and perceptual heuristics from Laws of UX.

Sources: [Rauno Freiberg](https://rauno.me/craft/interaction-design), [Jakub Królikowski](https://jakub.kr/work/drag-gesture), [Laws of UX](https://lawsofux.com)

### type-craft

Typography systems. Modular type scales with named ratios, fixed vs fluid typography (app UIs vs marketing), vertical rhythm and baseline grids, font loading strategy (`font-display: swap` + metric overrides + subsetting + preload + self-host), OpenType features (`kern`, `liga`, `calt`, `tabular-nums`, `oldstyle-nums`), variable font axes and optical sizing, font pairing (the rule of contrast, strategies), and text rendering (`antialiased`, `optimizeLegibility`, `text-wrap: balance`/`pretty`).

### colour-craft

Colour systems built on OKLCH. Why HSL fails, perceptually uniform scale generation with chroma tapering, neutral scales, semantic colour mapping (`--color-{role}-{variant}`), light/dark theme construction (remap semantics, not primitives), accessible contrast (WCAG 2.x AA baseline + APCA secondary check), colour blindness (the "never colour alone" rule, testing for all three types), and wide gamut P3.

Source: [OKLCH.fyi](https://oklch.fyi)

### detail-craft

Platform-specific implementation details and visual polish. Forms and inputs (labels, types, decorations, autocomplete), toggles and buttons (dead zones, `user-select`, `pointer-events`), dropdowns (`mousedown`, prediction cones), tooltips (delay skipping on subsequent tooltips), touch (`@media (hover: hover)`, iOS 16px zoom, auto-focus, video autoplay, tap highlight, `touch-action`), scroll (smooth anchors, pause off-screen), performance (`blur()` cost, banding, GPU compositing, `will-change`, React refs for real-time values), accessibility micro-details (disabled tooltips, focus rings, arrow keys, `aria-label`, gradient text selection), implementation patterns (optimistic updates, auth redirects, `::selection`, feedback placement, empty states, theme switching, `document.hidden` timer pause, hover gap-fill, pointer capture), and visual polish (concentric border radius, optical alignment, shadow depth via token-craft scale, image outlines).

Sources: [Rauno Freiberg](https://interfaces.rauno.me), [Jakub Królikowski](https://jakub.kr/writing/details-that-make-interfaces-feel-better), [Emil Kowalski](https://emilkowal.ski/ui/building-a-toast-component), [Derek Briggs](https://x.com/PixelJanitor)

---

## How They Trigger

Each skill fires independently based on the task. They don't fire in bulk on every request.

**"Set up the type system"** — type-craft fires.

**"This hover is sticky on mobile"** — detail-craft fires.

**"Should this modal animate?"** — interaction-craft fires.

**"What easing curve for this entrance?"** — motion-craft fires.

**"Create a colour palette with dark mode"** — colour-craft fires.

### The motion/interaction seam

interaction-craft says: "This modal should grow from its trigger, be interruptible, and skip animation when opened via keyboard shortcut."

motion-craft says: use `cubic-bezier(0.16, 1, 0.3, 1)` at 250ms on `transform` and `opacity`, `transform-origin` at the trigger position, minimum scale 0.85.

Two different mental modes. One is taste. The other is specification.

---

## Installation

### Option A: Install script

From your project's root directory:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/ui-craft/main/install.sh | sh
```

Or clone and run locally:

```sh
git clone https://github.com/olzn/ui-craft.git
cd ui-craft
sh install.sh
```

### Option B: Manual

Copy the skill folders into your project's `.claude/skills/` directory:

```
your-project/
└── .claude/
    └── skills/
        ├── design-philosophy.md
        ├── accessibility.md
        ├── composition.md
        ├── motion-craft/
        │   └── SKILL.md
        ├── interaction-craft/
        │   └── SKILL.md
        ├── type-craft/
        │   └── SKILL.md
        ├── colour-craft/
        │   └── SKILL.md
        └── detail-craft/
            └── SKILL.md
```

Or install globally to `~/.claude/skills/` for availability across all projects.

### Other AI harnesses

The SKILL.md files are standard markdown with YAML frontmatter. Adapt file locations to your tool's conventions.

---

## Companion: system-craft

The structural counterpart to this suite. Covers design tokens, component APIs, and composite UI patterns.

**[github.com/olzn/system-craft](https://github.com/olzn/system-craft)**

---

## Learnings

Each skill includes a `learnings.md` convention. After completing a task with a skill, patterns, edge cases, and library quirks are appended to a `learnings.md` file in that skill's folder. The skill consults this file before starting new tasks.

---

## Attribution

This skill suite is distilled from:

- [Family Values](https://benji.org/family-values) by Benji Taylor — the design philosophy behind [Family](https://family.co)
- [interfaces](https://github.com/raunofreiberg/interfaces) by Rauno Freiberg — the original web interface guidelines
- [Invisible Details of Interaction Design](https://rauno.me/craft/interaction-design) by Rauno Freiberg — interaction design principles
- [Emil Kowalski's essays](https://emilkowal.ski) — practical animation knowledge
- [Derek Briggs](https://x.com/PixelJanitor/status/1735758919509684360) — multi-layer shadow stack technique
- [12 Principles of Animation](https://www.raphaelsalaja.com/library/12-principles-of-animation) by Raphael Salaja — animation principles adapted for UI
- [Jakub Królikowski](https://jakub.kr) — interface details and drag gesture patterns
- [Laws of UX](https://lawsofux.com) — perceptual heuristics for interaction design
- [OKLCH.fyi](https://oklch.fyi) — OKLCH colour space tooling

All original ideas, principles, and guidelines belong to their respective authors. This repo packages their insights as Claude Code skills for easy use.

> **Note:** The original [interfaces](https://github.com/raunofreiberg/interfaces) repo does not specify a license. This skill is shared in good faith for educational purposes with full attribution. If you are an original author and have concerns, please open an issue.

---

## Licence

MIT
