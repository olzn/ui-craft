# UI Craft

UI Craft is a two-suite skillset for building web interfaces with stronger structure, clearer naming, and better surface quality.

It contains:

- **surface-craft**: how interfaces look, move, respond, adapt to platform constraints, and feel in use.
- **system-craft**: what interface parts are made from, what they are called, and how they fit into a reusable system.

The suite is designed for Codex, Claude Code, and other agents that can read `SKILL.md` files with YAML frontmatter.

---

## Repository Structure

```text
ui-craft/
├── surface-craft/
│   ├── README.md
│   ├── accessibility.md
│   ├── composition.md
│   ├── design-philosophy.md
│   ├── motion-craft/
│   ├── interaction-craft/
│   ├── type-craft/
│   ├── colour-craft/
│   └── detail-craft/
└── system-craft/
    ├── README.md
    ├── token-craft/
    ├── naming-craft/
    ├── component-craft/
    └── pattern-craft/
```

Each skill folder contains a `SKILL.md`. Some skills also include:

- `references/`: detailed guidance loaded only when needed.
- `agents/openai.yaml`: UI metadata for OpenAI skill clients.
- `learnings.md`: accumulated edge cases and practical findings.

---

## The Nine Skills

### Surface Craft

- **motion-craft**: animation implementation, easing, timing, transitions, exits, entrances, and motion polish.
- **interaction-craft**: gesture intent, spatial logic, frequency calibration, drag behaviour, and whether something should animate.
- **type-craft**: type scales, font loading, OpenType features, rhythm, wrapping, and rendering.
- **colour-craft**: OKLCH palettes, semantic colours, contrast, dark mode, colour blindness, and theme mapping.
- **detail-craft**: browser quirks, input details, touch behaviour, focus handling, performance micro-details, and visual polish.

### System Craft

- **token-craft**: design token architecture, foundation scales, semantic mappings, and theming.
- **naming-craft**: labels, commands, variables, classes, tokens, icons, components, features, products, and UI terminology.
- **component-craft**: reusable component APIs, variants, composition, state coverage, and icon conventions.
- **pattern-craft**: forms, navigation, tables, feedback, layouts, and larger product patterns.

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
motion-craft/
interaction-craft/
type-craft/
colour-craft/
detail-craft/
token-craft/
naming-craft/
component-craft/
pattern-craft/
```

The shared references are deliberately flat because individual skills point to them by filename.

---

## How To Start

Read:

- [surface-craft/README.md](surface-craft/README.md) for the experiential surface layer.
- [system-craft/README.md](system-craft/README.md) for the structural system layer.
- [surface-craft/composition.md](surface-craft/composition.md) for sequencing and lead-skill selection.

---

## Attribution

This suite distils ideas from many designers, engineers, and design-system practitioners, including Benji Taylor, Rauno Freiberg, Emil Kowalski, Jakub Krolikowski, Derek Briggs, Raphael Salaja, Laws of UX, NN/g, Polaris, Intuit, Vodafone, and others cited inside the relevant skill documents.

All original ideas and guidelines belong to their respective authors. This repo packages those influences as agent skills for practical interface work.

---

## Licence

MIT
