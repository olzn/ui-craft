# Rauno Design Skills

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills for building polished web interfaces, based on the work of [Rauno Freiberg](https://rauno.me).

## Skills

### `web-interface-guidelines`

A practical checklist for web interface details — interactivity, typography, motion, touch, performance, accessibility, and design patterns.

Based on [github.com/raunofreiberg/interfaces](https://github.com/raunofreiberg/interfaces).

### `interaction-design-principles`

Conceptual principles for understanding why great interactions work — metaphors, gesture thresholds, kinetic physics, spatial consistency, and animation trade-offs.

Based on [Invisible Details of Interaction Design](https://rauno.me/craft/interaction-design).

## Installation

### Option A: Install script

From your project's root directory:

```sh
curl -fsSL https://raw.githubusercontent.com/olozano/rauno-design-skills/main/install.sh | sh
```

Or clone and run locally:

```sh
git clone https://github.com/olozano/rauno-design-skills.git
cd rauno-design-skills
sh install.sh
```

### Option B: Manual

Copy the skill files into your project's `.claude/skills/` directory:

```sh
mkdir -p .claude/skills
cp interaction-design-principles.md .claude/skills/
cp web-interface-guidelines.md .claude/skills/
```

## Attribution

These skills are distilled from the work of [Rauno Freiberg](https://rauno.me). All original ideas, principles, and guidelines belong to him. This repo simply packages his insights as Claude Code skills for easy use.

- [interfaces](https://github.com/raunofreiberg/interfaces) — the original web interface guidelines repo
- [Invisible Details of Interaction Design](https://rauno.me/craft/interaction-design) — the original essay on interaction design

> **Note:** The original [interfaces](https://github.com/raunofreiberg/interfaces) repo does not specify a license. These skills are shared in good faith for educational purposes with full attribution. If you are the original author and have concerns, please open an issue.
