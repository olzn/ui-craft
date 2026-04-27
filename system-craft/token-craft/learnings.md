# Learnings

## Tailwind v4 CSS-first config
**Context:** Setting up tokens in a Tailwind v4 project.
**Finding:** Tailwind v4 uses `@theme` in CSS instead of `tailwind.config.js`. Tokens defined via `@theme` are available as utilities and CSS variables simultaneously, eliminating the need for a separate CSS custom properties file.
**Resolution:** For Tailwind v4 projects, define the token scale inside `@theme {}` blocks in CSS. For earlier versions, maintain the separate custom properties approach.

## `color-mix()` for alpha variants
**Context:** Generating transparent variants of semantic colour tokens without duplicating the scale.
**Finding:** `color-mix(in oklch, var(--color-brand-primary) 60%, transparent)` creates alpha variants from any token at the point of use. This avoids creating separate `--color-brand-primary-60` tokens for every opacity level.
**Resolution:** Use `color-mix()` for one-off alpha variants. Only create dedicated alpha tokens when the same value appears in 3+ places.

## Radix Themes numbered scale mapping
**Context:** Integrating token-craft's scale with Radix Themes components.
**Finding:** Radix Themes uses a 1-12 numbered scale per colour, where steps 1-2 are backgrounds, 3-5 are interactive surfaces, 6-8 are borders, 9-10 are solid colours, and 11-12 are text. This maps cleanly to the primitive→semantic model but the step numbers differ from Tailwind's 50-950 convention.
**Resolution:** When using Radix Themes, map its numbered steps to semantic tokens rather than trying to rename the scale. Document the mapping in the project's token file.
