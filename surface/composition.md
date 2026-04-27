# Composition

How the ten domain skills across surface and system work together. Use this guide to determine which skills to invoke, in what order, for common tasks.

---

## Suite Boundary

**system** handles structural questions: what the interface is made from, what things are called, how they are tokenised, how components are contracted, and how components assemble into reusable product patterns.

**surface** handles experiential questions: how those parts look, move, respond, adapt to platform constraints, meet accessibility expectations, and feel in use.

Use this split before choosing an individual skill. Naming, tokens, component APIs, and composite patterns lead to system. Typography, copy, colour, motion, interaction behaviour, platform details, and visual polish lead to surface.

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

1. **system-naming**: shared terminology, token/component naming grammar, feature labels
2. **system-tokens**: spacing, radius, shadow, z-index, breakpoint, motion tokens
3. **surface-typography**: type scale, font loading, font pairing
4. **surface-colour**: OKLCH palette, semantic colour mapping, light/dark themes
5. **system-components**: base component conventions (prop names, CVA, forwarding)
6. **system-patterns**: layout structure, navigation, feedback strategy
7. **surface-copy**: empty states, errors, onboarding, and helper text

### Building a page

1. **system-patterns** (lead): layout pattern, navigation, data display, feedback
2. **system-components**: components needed for the page
3. **surface-copy**: page copy, empty states, errors, helper text
4. **surface-colour**: verify contrast in both themes
5. **surface-typography**: verify scale, rhythm, and hierarchy
6. **surface-details**: platform details, touch, scroll, performance
7. **surface-motion**: entrance animations, scroll reveals
8. **surface-interaction**: gesture decisions, frequency calibration

### Building a component

1. **system-components** (lead): API design, variants, states, composition
2. **system-naming**: verify component, part, prop, icon, and label terminology
3. **system-tokens**: verify tokens exist for all values used
4. **surface-details**: platform quirks, accessibility micro-details
5. **surface-motion**: hover/press/focus transitions, entrance/exit
6. **surface-colour**: contrast check

### Design system audit

1. **system-tokens** (lead): hardcoded values, scale coverage, token architecture
2. **system-naming**: terminology drift, aliases, token/component/feature naming consistency
3. **system-components**: API consistency, missing states, variant alignment
4. **surface-colour**: contrast compliance, colour blindness, theme coverage
5. **surface-typography**: scale adherence, loading performance, feature usage
6. **surface-copy**: error, empty, onboarding, and helper copy consistency
7. **system-patterns**: feedback consistency, navigation structure, form validation

### Visual polish pass

1. **surface-details** (lead): concentric radii, optical alignment, shadows, hit areas, safe areas, selection
2. **surface-copy**: unclear labels' surrounding text, empty states, errors, helper text
3. **surface-motion**: easing, duration, paired timing, exit patterns, stagger
4. **surface-interaction**: frequency calibration, spatial consistency, staging
5. **surface-colour**: dark mode fine-tuning, brand colour adjustments

---

## Which Skill Leads

| Task type | Lead skill | Always also check |
|---|---|---|
| Naming or terminology | system-naming | Relevant domain skill |
| Token/scale setup | system-tokens | surface-colour, surface-typography |
| Colour palette or theme | surface-colour | system-tokens |
| Type system | surface-typography | system-tokens |
| Interface copy or UX writing | surface-copy | system-naming |
| New component | system-components | system-naming, system-tokens, surface-details |
| Page layout | system-patterns | system-components, surface-details |
| Form implementation | system-patterns | system-components, surface-details |
| Navigation structure | system-patterns | system-components, surface-interaction |
| Data display (tables, lists) | system-patterns | system-components |
| Animation implementation | surface-motion | surface-interaction |
| Gesture design | surface-interaction | surface-motion, surface-details |
| Platform bug or quirk | surface-details | None |
| Accessibility review | See `accessibility.md` | All relevant skills |
| Design system audit | system-tokens | All skills |
| Visual polish | surface-details | surface-motion, surface-colour |
| Feedback (toast/inline/banner) | system-patterns | surface-details, surface-motion |

---

## Cross-Skill Boundaries

These are the most common boundary questions:

**"Should this animate?"** → surface-interaction decides. **"How should it animate?"** → surface-motion implements.

**"What should this be called?"** → system-naming decides. **"How should it be built?"** → the relevant domain skill implements.

**"What should this action be called?"** → system-naming decides. **"What explanatory copy surrounds it?"** → surface-copy writes.

**"What shadow value?"** → system-tokens owns the scale. **"Box-shadow vs border?"** → surface-details recommends shadows.

**"What colour for dark mode?"** → surface-colour decides the mapping. **"How does theming work?"** → system-tokens owns the mechanism.

**"Where should this error show?"** → system-patterns decides placement. **"What does the error state look like?"** → system-components defines the visual state.

**"Is this contrast sufficient?"** → surface-colour checks. **"Is this perceivable without colour?"** → surface-colour's colour blindness rules + surface-details's accessibility micro-details.
