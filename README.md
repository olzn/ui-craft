# UI Craft

UI Craft is a two-suite skillset for building web interfaces with stronger structure, clearer naming, and better surface quality.

It contains:

- **ui-craft**: an agent-facing coordinator skill for routing broad UI tasks and applying suite best practices.
- **surface**: how interfaces look, read, move, respond, adapt to platform constraints, and feel in use.
- **system**: what interface parts are made from, what they are called, and how they fit into a reusable system.

The suite is designed for Codex, Claude Code, and other agents that can read `SKILL.md` files with YAML frontmatter.

---

## Repository Structure

```text
ui-craft/
├── ui-craft/
│   ├── SKILL.md
│   └── agents/openai.yaml
├── surface/
│   ├── README.md
│   ├── accessibility.md
│   ├── composition.md
│   ├── design-philosophy.md
│   ├── surface-motion/
│   ├── surface-interaction/
│   ├── surface-typography/
│   ├── surface-copy/
│   ├── surface-colour/
│   └── surface-details/
└── system/
    ├── README.md
    ├── system-tokens/
    ├── system-naming/
    ├── system-components/
    └── system-patterns/
```

Each skill folder contains a `SKILL.md`. Some skills also include:

- `references/`: detailed guidance loaded only when needed.
- `agents/openai.yaml`: UI metadata for OpenAI skill clients.
- `learnings.md`: accumulated edge cases and practical findings.

---

## Coordinator Skill

- **ui-craft**: routes broad UI tasks to the right domain skills, applies suite-level best practices, and keeps agents from loading every skill by default.

## The Ten Domain Skills

### Surface

- **surface-motion**: animation implementation, easing, timing, transitions, exits, entrances, and motion polish.
- **surface-interaction**: gesture intent, spatial logic, frequency calibration, drag behaviour, and whether something should animate.
- **surface-typography**: type scales, font loading, OpenType features, rhythm, wrapping, and rendering.
- **surface-copy**: interface copy, microcopy, errors, empty states, onboarding, tooltips, and UX writing.
- **surface-colour**: OKLCH palettes, semantic colours, contrast, dark mode, colour blindness, and theme mapping.
- **surface-details**: browser quirks, input details, touch behaviour, focus handling, performance micro-details, and visual polish.

### System

- **system-tokens**: design token architecture, foundation scales, semantic mappings, and theming.
- **system-naming**: labels, commands, variables, classes, tokens, icons, components, features, products, and UI terminology.
- **system-components**: reusable component APIs, variants, composition, state coverage, and icon conventions.
- **system-patterns**: forms, navigation, tables, feedback, layouts, and larger product patterns.

---

## When To Use UI Craft

Use UI Craft when an agent is building, reviewing, or refactoring web interface work where quality depends on design judgement as much as code correctness.

Good fits:

- Building a new app screen, product feature, settings page, dashboard, form, table, command menu, modal, or navigation structure.
- Creating or auditing a design system, token architecture, component library, or shared UI vocabulary.
- Reviewing frontend work for visual polish, accessibility, motion, interaction behaviour, naming consistency, and production readiness.
- Turning a rough implementation into something coherent, usable, and shippable.
- Debugging browser-specific interface problems such as iOS input zoom, sticky hover, scroll lock, focus return, layout shift, or animation jank.

Poor fits:

- Backend-only work with no user interface.
- Pure data modelling, infrastructure, deployment, or API design.
- Brand strategy, marketing naming, or product positioning without an interface or design-system surface.
- Native mobile interface work where web platform rules do not apply.

---

## Best Practices

Use the narrowest relevant skill first. If you need a button API, start with `system-components`, not the whole suite. If you need the button label, use `system-naming`. If the button feels visually off, use `surface-details` or `surface-motion`.

Start with structure, then refine the surface. For new work, the usual order is:

```text
system-naming -> system-tokens -> system-components -> system-patterns -> surface-copy -> surface skills
```

For existing UI, reverse the order when the structure already exists:

```text
surface-details -> surface-copy -> surface-motion -> surface-typography -> surface-colour -> system-components
```

Do not invoke every skill by default. The suite works best when the lead skill is clear and supporting skills are pulled in only for their specific domain.

Use `surface/composition.md` for multi-skill tasks. It defines common sequences for new project setup, component work, page work, audits, accessibility reviews, and visual polish passes.

Keep `learnings.md` useful. When a project-specific browser quirk, library behaviour, or implementation edge case appears, add a short finding to the relevant skill's `learnings.md` so the suite improves through use.

Treat references as optional depth. The `references/` files are for detailed recipes and audits, not material that needs to be loaded for every task.

---

## Skill Selection

| Task | Lead skill | Also check |
|---|---|---|
| Name a feature, command, button, token, or component | `system-naming` | Relevant domain skill |
| Write or revise explanatory UX text | `surface-copy` | `system-naming` for terms |
| Define spacing, colour semantics, radius, shadow, or theme mappings | `system-tokens` | `surface-colour`, `surface-typography` |
| Build a reusable component | `system-components` | `system-naming`, `system-tokens`, `surface-details` |
| Design a form, table, navigation, feedback system, or page layout | `system-patterns` | `system-components`, `surface-details` |
| Decide whether something should animate or how a gesture should behave | `surface-interaction` | `surface-motion` |
| Implement easing, timing, transitions, entrances, exits, or icon swaps | `surface-motion` | `surface-interaction`, `surface-details` |
| Set up type scale, font loading, wrapping, rhythm, or OpenType features | `surface-typography` | `system-tokens` |
| Build palettes, contrast, dark mode, or colour-blind-safe states | `surface-colour` | `system-tokens` |
| Polish browser details, focus, touch, inputs, scroll, or visual finish | `surface-details` | `surface-motion`, `accessibility.md` |

---

## Prompt Examples

```text
Use $system-patterns and $system-components to design a billing settings form with validation, loading, error, and empty states.
```

```text
Use $system-naming to audit these component, token, and Figma layer names for consistency.
```

```text
Use $surface-copy to improve the error messages, empty states, helper text, and onboarding copy in this flow.
```

```text
Use $surface-interaction first, then $surface-motion, to decide and implement the behaviour for this swipe-to-dismiss card.
```

```text
Use $surface-details to review this modal for focus return, scroll lock, touch behaviour, safe areas, and visual polish.
```

```text
Use $system-tokens and $surface-colour to define semantic colour tokens for light and dark themes with accessible contrast.
```

Use `surface-copy` for explanatory or persuasive writing such as error message bodies, empty states, onboarding, tooltips, loading copy, and marketing-style CTAs. Use `system-naming` for product action labels, commands, feature names, UI terminology, and copy that must stay consistent across code, Figma, docs, analytics, or a glossary.

---

## Installation

Install globally for Codex:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/ui-craft/main/install.sh | sh
```

By default, this installs to:

```text
${CODEX_HOME:-$HOME/.codex}/skills
```

Install into a project or Claude Code folder by setting `TARGET_DIR`:

```sh
TARGET_DIR=.claude/skills sh install.sh
```

From a local clone:

```sh
git clone https://github.com/olzn/ui-craft.git
cd ui-craft
sh install.sh
```

---

## Manual Installation

Copy the shared surface references into your skills directory:

```text
design-philosophy.md
accessibility.md
composition.md
```

Then copy each skill folder into the same directory:

```text
ui-craft/
surface-motion/
surface-interaction/
surface-typography/
surface-copy/
surface-colour/
surface-details/
system-tokens/
system-naming/
system-components/
system-patterns/
```

The shared references are deliberately flat because individual skills point to them by filename.

---

## How To Start

Read:

- [surface/README.md](surface/README.md) for the experiential surface layer.
- [system/README.md](system/README.md) for the structural system layer.
- [surface/composition.md](surface/composition.md) for sequencing and lead-skill selection.

---

## Attribution

This suite distils ideas from many designers, engineers, and design-system practitioners, including Benji Taylor, Rauno Freiberg, Emil Kowalski, Jakub Krolikowski, Derek Briggs, Raphael Salaja, Laws of UX, NN/g, Polaris, Intuit, Vodafone, and others cited inside the relevant skill documents.

All original ideas and guidelines belong to their respective authors. This repo packages those influences as agent skills for practical interface work.

---

## Licence

MIT
