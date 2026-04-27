---
name: system-tokens
description: Set up and maintain design token architecture and foundation scales. Use when defining spacing, radius, shadow, z-index, breakpoint, or motion scales, establishing the primitive/semantic/component token model, naming tokens, configuring theming, or auditing hardcoded values. Also triggers for "design tokens", "CSS custom properties", "token naming", "semantic layer", "spacing scale", "theming", or "hardcoded values". Provides scale definitions and structural rules that distribute colour, type, and motion values across a system. Does NOT cover broad naming taxonomies, UI terminology, user-facing labels, feature names, or product names (use system-naming). Does NOT cover component APIs (use system-components), composite patterns (use system-patterns), palettes (use surface-colour), or type scales (use surface-typography).
---

# Tokens

Design token architecture and foundation scales. Tokens are the distribution layer that ensures every component draws from the same well. surface-colour, surface-typography, and surface-motion define the values. This skill defines how those values are structured, named, and distributed.

Based on the [Design System Checklist](https://www.designsystemchecklist.com) and the token patterns of Tailwind, Radix Themes, and Open Props.

For the shared design philosophy, see `design-philosophy.md`.

**Apply this when setting up a project's design foundations or auditing token consistency.** For broad naming and terminology decisions, use system-naming. For multi-skill task sequencing, see `composition.md`.

---

## Three-Layer Model

```
Primitive    →    Semantic    →    Component
(raw value)       (meaning)        (scoped)
```

**Primitive tokens** describe what the value is: `--blue-500`, `--space-4`, `--radius-md`. They are the raw palette.

**Semantic tokens** describe what the value means: `--color-brand-primary`, `--space-gap-default`, `--radius-card`. Components reference these, never primitives directly.

**Component tokens** scope semantic values to a specific component: `--button-padding-x`, `--card-radius`. These are optional and only needed when a component's value diverges from the semantic default.

The semantic layer is never optional. Without it, theming breaks, and changing a brand colour means hunting through every component file.

---

## Naming Convention

For cross-surface naming decisions, controlled vocabulary, Figma variable naming, and token taxonomy audits, use system-naming. This section defines the token architecture rule.

```
--{category}-{property}-{modifier}
```

Lowercase, hyphen-separated. Category first (enables autocomplete grouping in editors).

- Primitives: `--{scale}-{step}` (e.g., `--gray-500`, `--space-4`, `--radius-md`)
- Semantics: `--{category}-{role}-{variant}` (e.g., `--color-text-primary`, `--space-gap-default`)
- Component: `--{component}-{property}` (e.g., `--button-padding-x`, `--card-shadow`)

No component names in semantic tokens. `--color-primary` not `--button-color`. The semantic layer must be component-agnostic so multiple components can share it.

---

## Foundation Scales

### Spacing

Base-4 scale in `rem`. Every margin, padding, and gap comes from this scale.

```css
--space-0:  0;
--space-1:  0.25rem;   /* 4px */
--space-2:  0.5rem;    /* 8px */
--space-3:  0.75rem;   /* 12px */
--space-4:  1rem;      /* 16px */
--space-5:  1.25rem;   /* 20px */
--space-6:  1.5rem;    /* 24px */
--space-8:  2rem;      /* 32px */
--space-10: 2.5rem;    /* 40px */
--space-12: 3rem;      /* 48px */
--space-16: 4rem;      /* 64px */
--space-20: 5rem;      /* 80px */
--space-24: 6rem;      /* 96px */
```

The scale jumps from 6 to 8 to 10. The middle of the scale (4-8) is where most UI spacing lives and needs the finest granularity. The extremes are coarser.

Map to semantics: `--space-gap-default: var(--space-4)`, `--space-section-y: var(--space-16)`.

### Border Radius

```css
--radius-none: 0;
--radius-sm:   0.25rem;   /* 4px */
--radius-md:   0.5rem;    /* 8px */
--radius-lg:   0.75rem;   /* 12px */
--radius-xl:   1rem;      /* 16px */
--radius-2xl:  1.5rem;    /* 24px */
--radius-full: 9999px;
```

Remember the concentric radius rule from surface-details: nested elements use `outer radius - padding` for their inner radius.

### Shadow

Elevation model using the Derek Briggs method: match Y-offset and blur-radius for each layer, apply negative spread at half the Y value (prevents the shadow from expanding wider than the element), and use uniform colour/opacity across all layers. The first layer (spread-only, no blur) acts as a subtle border.

```css
--shadow-xs:
  0 0 0 1px rgba(0, 0, 0, 0.05),
  0 1px 1px -0.5px rgba(0, 0, 0, 0.05);

--shadow-sm:
  0 0 0 1px rgba(0, 0, 0, 0.06),
  0 1px 1px -0.5px rgba(0, 0, 0, 0.06),
  0 3px 3px -1.5px rgba(0, 0, 0, 0.06);

--shadow-md:
  0 0 0 1px rgba(0, 0, 0, 0.06),
  0 1px 1px -0.5px rgba(0, 0, 0, 0.06),
  0 3px 3px -1.5px rgba(0, 0, 0, 0.06),
  0 6px 6px -3px rgba(0, 0, 0, 0.06);

--shadow-lg:
  0 0 0 1px rgba(0, 0, 0, 0.06),
  0 1px 1px -0.5px rgba(0, 0, 0, 0.06),
  0 3px 3px -1.5px rgba(0, 0, 0, 0.06),
  0 6px 6px -3px rgba(0, 0, 0, 0.06),
  0 12px 12px -6px rgba(0, 0, 0, 0.06);

--shadow-xl:
  0 0 0 1px rgba(0, 0, 0, 0.06),
  0 1px 1px -0.5px rgba(0, 0, 0, 0.06),
  0 3px 3px -1.5px rgba(0, 0, 0, 0.06),
  0 6px 6px -3px rgba(0, 0, 0, 0.06),
  0 12px 12px -6px rgba(0, 0, 0, 0.06),
  0 24px 24px -12px rgba(0, 0, 0, 0.06);
```

Each elevation step adds one more layer. Higher elevation = more layers, further spread. The uniform opacity means you can tune the entire shadow system by changing a single alpha value.

Map to semantics: `--shadow-card: var(--shadow-sm)`, `--shadow-dropdown: var(--shadow-lg)`, `--shadow-modal: var(--shadow-xl)`.

### Z-Index

Named layers prevent z-index wars. Every z-index comes from this list.

```css
--z-base:     0;
--z-raised:   1;
--z-dropdown: 10;
--z-sticky:   20;
--z-overlay:  30;
--z-modal:    40;
--z-popover:  50;
--z-toast:    60;
--z-tooltip:  70;
```

The 10-step gaps allow insertion if new layers are needed later.

### Breakpoints

```css
--breakpoint-sm:  640px;
--breakpoint-md:  768px;
--breakpoint-lg:  1024px;
--breakpoint-xl:  1280px;
--breakpoint-2xl: 1536px;
```

Mobile-first: base styles for smallest screen, `@media (min-width: ...)` adds complexity for larger screens.

### Motion Tokens

Duration and easing as tokens. The values come from surface-motion; these tokens distribute them.

```css
--duration-instant:  0ms;
--duration-fast:     100ms;
--duration-normal:   200ms;
--duration-slow:     300ms;
--ease-default:      cubic-bezier(0.16, 1, 0.3, 1);
--ease-in:           cubic-bezier(0.4, 0, 1, 1);
--ease-out:          cubic-bezier(0, 0, 0.2, 1);
```

### Icon Sizing

Aligned to the type scale:

```css
--icon-xs:  0.875rem;  /* 14px */
--icon-sm:  1rem;      /* 16px */
--icon-md:  1.25rem;   /* 20px */
--icon-lg:  1.5rem;    /* 24px */
--icon-xl:  2rem;      /* 32px */
```

---

## Units

- Spacing and font sizes: `rem` (scales with user preference)
- Borders and outlines: `px` (should not scale)
- Line-heights: unitless (inherits correctly)
- Breakpoints: `px` (fixed device thresholds)
- Shadows: `px` with `rgba` (visual, not structural)

---

## Theming

Primitives never change between themes. Only semantic tokens remap. This is the core rule of themeable systems.

```css
:root, [data-theme="light"] {
  --color-text-primary:    var(--neutral-900);
  --color-surface-default: var(--neutral-50);
}

[data-theme="dark"] {
  --color-text-primary:    var(--neutral-100);
  --color-surface-default: var(--neutral-950);
}
```

Support `prefers-color-scheme` as the default, with `data-theme` as a user override. Components never check the current theme. They reference semantic tokens that resolve automatically.

For colour-specific theming decisions (dark mode surface values, brand colour adjustments), see surface-colour.

---

## Anti-Patterns

1. **Hardcoded values in components.** Any colour, spacing, radius, shadow, or z-index not referencing a token.
2. **Skipping the semantic layer.** `var(--blue-500)` directly in a component instead of `var(--color-brand-primary)`.
3. **Component names in semantic tokens.** `--button-bg` as a semantic. Semantics are role-based, not component-scoped.
4. **Z-index guessing.** `z-index: 999` or `z-index: 99999` instead of the named scale.
5. **Arbitrary spacing.** `padding: 13px` or `gap: 0.6rem` that falls outside the spacing scale.
6. **Mixed units.** `rem` for some spacing, `px` for others. Consistent units prevent inheritance bugs.

---

## Checklist

### Architecture
- Three-layer model implemented (primitive, semantic, component)
- Token names follow `--{category}-{property}-{modifier}` convention
- No component names in semantic tokens
- Semantic layer exists between primitives and component code

### Scales
- Spacing scale defined (base-4, in `rem`)
- Border radius scale defined
- Shadow elevation scale defined
- Z-index named layers defined
- Breakpoint tokens defined (mobile-first)
- Motion tokens (duration, easing) defined
- Icon sizing scale defined

### Theming
- Primitives identical across themes
- Only semantic tokens remap between themes
- `prefers-color-scheme` respected as default
- Components never check the current theme

### Hygiene
- No hardcoded colour, spacing, radius, shadow, or z-index in component code
- All values use correct units (rem/px/unitless as specified)
- No spacing values outside the scale

---

## Learning from Usage

After completing a token or scale setup task, review the output against the checklist. Append findings to `learnings.md` in this skill's folder. Consult `learnings.md` before starting any new task.
