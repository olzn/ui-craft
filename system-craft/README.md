# System Craft

Codex and Claude Code skills for structuring design systems, naming, component libraries, and composite UI patterns.

Four focused skills covering the full arc from naming and foundation tokens through individual components to assembled features. Each skill owns a single layer of the design system stack.

Companion to surface-craft, which covers copy, motion, interaction design, typography, colour, and platform implementation. Both suites live in the [ui-craft](https://github.com/olzn/ui-craft) repo.

---

## Suite Boundary

**system-craft defines what the interface is made from and how those parts are named, structured, and reused.** It is the structural design-system layer: vocabulary, tokens, component contracts, and composed patterns.

Use **surface-craft** when deciding how those parts look, read, move, respond, and feel in use: typography, copy, colour, motion, interaction behaviour, browser details, and visual polish.

Rule of thumb: if the question is "what is this thing, what is it called, and how does it fit into the reusable system?", start with system-craft. If the question is "how should this render, read, feel, move, or behave in the browser?", use surface-craft.

---

## The Suite

```
system-craft/
├── naming-craft/SKILL.md      Naming across UI, code, tokens, components, icons, and products.
├── token-craft/SKILL.md       Design tokens and foundation scales.
├── component-craft/SKILL.md   Component APIs, composition, states.
└── pattern-craft/SKILL.md     Composite UI patterns.
```

For cross-suite references, see surface-craft's `accessibility.md` (accessibility requirements across all ten domain skills) and `composition.md` (multi-skill task sequencing and lead-skill lookup).

### token-craft

Design token architecture and foundation scales. The three-layer model (primitive, semantic, component), naming conventions (`--{category}-{property}-{modifier}`), and concrete scales for spacing (base-4), border radius, shadow (Derek Briggs natural shadow method with matched Y/blur, negative spread, uniform opacity), z-index (named layers), breakpoints (mobile-first), motion tokens, and icon sizing. Plus units guidance (`rem` for spacing, `px` for borders, unitless for line-heights) and theming (primitives never change, only semantics remap).

Based on the [Design System Checklist](https://www.designsystemchecklist.com) and the token patterns of Tailwind, Radix Themes, and Open Props.

Sources: [Design System Checklist](https://www.designsystemchecklist.com), [Derek Briggs](https://x.com/PixelJanitor) (natural shadow method)

### naming-craft

Naming rules for product interfaces, design systems, and implementation code. Covers button labels, commands, menu items, fields, variables, CSS classes, CSS custom properties, design tokens, Figma variables, Figma layers, UI components, icons, colour names, feature names, product names, navigation labels, and UX terminology. Provides a naming workflow, surface-specific name shapes, controlled vocabulary discipline, and a taxonomy reference for cross-surface audits.

Sources: [NN/g UI copy](https://www.nngroup.com/articles/ui-copy/), [Classnames](https://classnames.paulrobertlloyd.com), [Shopify Polaris naming](https://polaris-react.shopify.com/content/naming), [Component Gallery](https://component.gallery/components/), [Good Practices naming](https://goodpractices.design/guidelines/naming), [Design Systems iconography](https://www.designsystems.com/iconography-guide/), [Intuit token taxonomy](https://medium.com/@NateBaldwin/creating-a-flexible-design-token-taxonomy-for-intuits-design-system-81c8ff55c59b), [Vodafone variables taxonomy](https://medium.com/vodafone-uk-design-experience/figma-variables-at-vodafone-uk-how-we-structured-taxonomy-for-a-complex-multi-brand-design-system-693b1b95675f), [Moccu naming convention](https://www.moccu.com/en/insights/digital-design/naming-convention-a-helpful-framework-for-structuring-design-systems/), [Color.pizza](https://parrot.color.pizza), [Onym](https://guide.onym.co), [Naming Cheatsheet](https://github.com/kettanaito/naming-cheatsheet)

### component-craft

How to build reusable UI components with consistent APIs and complete state coverage. Prop conventions (`variant`, `size`, `disabled`, `loading`, no `is` prefix, string unions over booleans), variant systems (CVA with `defaultVariants`), forwarding (`ref`, `className`, rest props, `displayName`, React 19 note), safe native defaults (`type="button"`), controlled and uncontrolled patterns, composition (when to configure vs compose, the 4-content-prop rule, compound component naming, slots, render delegation via `asChild`/`render`, balanced customisability), component state coverage (interactive: default, hover, focus, active, disabled, loading; content: empty, loading, error, partial, complete), error strategy, icon system (colour inheritance via `currentColor`, sizing from token-craft scale, one library, accessibility), and tools (CVA, Radix Slot, Base UI, clsx + tailwind-merge).

Based on the component patterns of [Radix](https://www.radix-ui.com/primitives), [Base UI](https://base-ui.com), and [shadcn/ui](https://ui.shadcn.com).

### pattern-craft

Composite UI patterns that assemble components into coherent features. The layer between "I have well-structured components" and "I have a well-structured product."

Covers: form patterns (validation timing with three strategies, error display, field grouping, multi-step with progress and backward navigation, submit behaviour), navigation patterns (top/sidebar/bottom tabs, mobile adaptation, active states, breadcrumbs, deep linking), data display patterns (tables with sort/filter/pagination/selection/responsive, lists, cards), feedback patterns (toast vs inline vs banner decision table, confirmation dialogs, progress indicators, optimistic updates), layout patterns (sidebar+main, dashboard grids with auto-fill, content density levels, responsive strategies, max-width by content type), search patterns (keyboard shortcut, debounce, arrow key navigation, empty states, URL-reflected filters), and modal/dialog patterns (modal vs page vs sheet decisions, focus trapping and return, dismiss behaviour, scroll lock, mobile adaptation, stacking avoidance, deep linking).

---

## How the Layers Work Together

**naming-craft** defines the vocabulary: "This is a popover, not a tooltip; this command is Delete project, not Confirm."

**token-craft** sets up the foundation once: "Here's the spacing scale, here's how token architecture works, here's how theming works."

**component-craft** uses those tokens to build individual components: "Here's a Button with consistent props, complete states, and forwarded refs."

**pattern-craft** assembles those components into features: "Here's how that Button, Input, and ErrorMessage work together as a form with validation timing and error placement."

---

## How They Trigger

**"Set up the spacing and token system"**: token-craft fires.

**"What should this component/button/feature be called?"**: naming-craft fires.

**"Build a reusable Button component"**: component-craft fires.

**"How should this form validate?"**: pattern-craft fires.

**"Build me a dashboard"**: pattern-craft fires (layout and data display patterns).

**"Where should errors show?"**: pattern-craft fires.

**"This component API feels wrong"**: component-craft fires.

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

## Companion: surface-craft

The visual, copy, and interaction counterpart to this suite. Covers motion, interaction design, typography, copy, colour, and platform implementation details.

**[github.com/olzn/ui-craft/tree/main/surface-craft](https://github.com/olzn/ui-craft/tree/main/surface-craft)**

---

## Learnings

Each skill includes a `learnings.md` convention. After completing a task with a skill, patterns, edge cases, and library quirks are appended to a `learnings.md` file in that skill's folder. The skill consults this file before starting new tasks.

---

## Licence

MIT
