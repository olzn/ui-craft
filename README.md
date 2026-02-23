# UI Craft

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill for building polished, intentional web interfaces.

Encodes the "Family Values" design philosophy — Simplicity, Fluidity, and Delight — alongside a concrete implementation checklist for CSS details, accessibility, touch, and performance.

Based on the work of [Benji Taylor](https://benji.org/family-values) and [Rauno Freiberg](https://rauno.me).

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

Download the skill file directly into your project's `.claude/skills/` directory:

```sh
mkdir -p .claude/skills
curl -fsSL https://raw.githubusercontent.com/olzn/ui-craft/main/ui-craft.md -o .claude/skills/ui-craft.md
```

## Attribution

This skill is distilled from:

- [Family Values](https://benji.org/family-values) by Benji Taylor — the design philosophy behind [Family](https://family.co)
- [interfaces](https://github.com/raunofreiberg/interfaces) by Rauno Freiberg — the original web interface guidelines
- [Invisible Details of Interaction Design](https://rauno.me/craft/interaction-design) by Rauno Freiberg — interaction design principles

All original ideas, principles, and guidelines belong to their respective authors. This repo packages their insights as a Claude Code skill for easy use.

> **Note:** The original [interfaces](https://github.com/raunofreiberg/interfaces) repo does not specify a license. This skill is shared in good faith for educational purposes with full attribution. If you are an original author and have concerns, please open an issue.
