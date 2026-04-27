# Composition

How the ten domain skills across surface-craft and system-craft work together. Use this guide to determine which skills to invoke, in what order, for common tasks.

---

## Suite Boundary

**system-craft** handles structural questions: what the interface is made from, what things are called, how they are tokenised, how components are contracted, and how components assemble into reusable product patterns.

**surface-craft** handles experiential questions: how those parts look, move, respond, adapt to platform constraints, meet accessibility expectations, and feel in use.

Use this split before choosing an individual skill. Naming, tokens, component APIs, and composite patterns lead to system-craft. Typography, copy, colour, motion, interaction behaviour, platform details, and visual polish lead to surface-craft.

---

## The General Order

```
naming -> tokens -> type + colour -> components -> patterns -> copy -> detail + motion + interaction
```

Shared vocabulary and foundation scales first. Visual values next. Structure third. Assembly fourth. Copy and polish last.

This is a dependency order, not a strict sequence. Later skills reference earlier ones, but you may loop back (e.g. adding a new token while building a component).

---

## Skill Sequence by Task

### New project setup

1. **naming-craft**: shared terminology, token/component naming grammar, feature labels
2. **token-craft**: spacing, radius, shadow, z-index, breakpoint, motion tokens
3. **type-craft**: type scale, font loading, font pairing
4. **colour-craft**: OKLCH palette, semantic colour mapping, light/dark themes
5. **component-craft**: base component conventions (prop names, CVA, forwarding)
6. **pattern-craft**: layout structure, navigation, feedback strategy
7. **copy-craft**: empty states, errors, onboarding, and helper text

### Building a page

1. **pattern-craft** (lead): layout pattern, navigation, data display, feedback
2. **component-craft**: components needed for the page
3. **copy-craft**: page copy, empty states, errors, helper text
4. **colour-craft**: verify contrast in both themes
5. **type-craft**: verify scale, rhythm, and hierarchy
6. **detail-craft**: platform details, touch, scroll, performance
7. **motion-craft**: entrance animations, scroll reveals
8. **interaction-craft**: gesture decisions, frequency calibration

### Building a component

1. **component-craft** (lead): API design, variants, states, composition
2. **naming-craft**: verify component, part, prop, icon, and label terminology
3. **token-craft**: verify tokens exist for all values used
4. **detail-craft**: platform quirks, accessibility micro-details
5. **motion-craft**: hover/press/focus transitions, entrance/exit
6. **colour-craft**: contrast check

### Design system audit

1. **token-craft** (lead): hardcoded values, scale coverage, token architecture
2. **naming-craft**: terminology drift, aliases, token/component/feature naming consistency
3. **component-craft**: API consistency, missing states, variant alignment
4. **colour-craft**: contrast compliance, colour blindness, theme coverage
5. **type-craft**: scale adherence, loading performance, feature usage
6. **copy-craft**: error, empty, onboarding, and helper copy consistency
7. **pattern-craft**: feedback consistency, navigation structure, form validation

### Visual polish pass

1. **detail-craft** (lead): concentric radii, optical alignment, shadows, hit areas, safe areas, selection
2. **copy-craft**: unclear labels' surrounding text, empty states, errors, helper text
3. **motion-craft**: easing, duration, paired timing, exit patterns, stagger
4. **interaction-craft**: frequency calibration, spatial consistency, staging
5. **colour-craft**: dark mode fine-tuning, brand colour adjustments

---

## Which Skill Leads

| Task type | Lead skill | Always also check |
|---|---|---|
| Naming or terminology | naming-craft | Relevant domain skill |
| Token/scale setup | token-craft | colour-craft, type-craft |
| Colour palette or theme | colour-craft | token-craft |
| Type system | type-craft | token-craft |
| Interface copy or UX writing | copy-craft | naming-craft |
| New component | component-craft | naming-craft, token-craft, detail-craft |
| Page layout | pattern-craft | component-craft, detail-craft |
| Form implementation | pattern-craft | component-craft, detail-craft |
| Navigation structure | pattern-craft | component-craft, interaction-craft |
| Data display (tables, lists) | pattern-craft | component-craft |
| Animation implementation | motion-craft | interaction-craft |
| Gesture design | interaction-craft | motion-craft, detail-craft |
| Platform bug or quirk | detail-craft | None |
| Accessibility review | See `accessibility.md` | All relevant skills |
| Design system audit | token-craft | All skills |
| Visual polish | detail-craft | motion-craft, colour-craft |
| Feedback (toast/inline/banner) | pattern-craft | detail-craft, motion-craft |

---

## Cross-Skill Boundaries

These are the most common boundary questions:

**"Should this animate?"** → interaction-craft decides. **"How should it animate?"** → motion-craft implements.

**"What should this be called?"** → naming-craft decides. **"How should it be built?"** → the relevant domain skill implements.

**"What should this action be called?"** → naming-craft decides. **"What explanatory copy surrounds it?"** → copy-craft writes.

**"What shadow value?"** → token-craft owns the scale. **"Box-shadow vs border?"** → detail-craft recommends shadows.

**"What colour for dark mode?"** → colour-craft decides the mapping. **"How does theming work?"** → token-craft owns the mechanism.

**"Where should this error show?"** → pattern-craft decides placement. **"What does the error state look like?"** → component-craft defines the visual state.

**"Is this contrast sufficient?"** → colour-craft checks. **"Is this perceivable without colour?"** → colour-craft's colour blindness rules + detail-craft's accessibility micro-details.
