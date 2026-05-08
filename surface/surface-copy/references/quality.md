# Quality

Cross-suite quality model for UI Craft. This is a shared reference, not a skill and not a new routing domain.

Quality means the absence of avoidable user-facing problems. A high-quality interface gives people fewer reasons to hesitate, recover, wait, relearn, or forgive the product. The goal is not perfection. The goal is to remove enough friction that the work feels reliable, clear, effective, efficient, and cared for.

Use this reference for prompts about quality, craft, papercuts, polish, entropy, "why does this feel bad?", or broad interface improvement where no single domain owns the issue.

---

## Signals

Map quality concerns to the skill that can change the outcome.

| Signal | Question | Primary owners |
|---|---|---|
| Reliability | Does it work every time, including edge states? | `system-components`, `system-patterns`, `accessibility.md` |
| Speed | Does it respond quickly and avoid waste? | `surface-details`, `surface-motion` |
| Clarity | Does the user understand what is happening and what to do next? | `system-naming`, `surface-copy`, `surface-typography` |
| Efficacy | Can the user complete the task? | `system-patterns` |
| Efficiency | Can the user complete the task with minimal avoidable effort? | `system-patterns`, `surface-interaction`, `surface-details` |
| Beauty | Does the interface feel visually considered? | `surface-typography`, `surface-colour`, `surface-motion`, `surface-details` |

Do not optimise one signal by damaging another. Beauty that hurts clarity is not quality. Speed that hides failure is not quality. Consistency that preserves a bad pattern is not quality.

---

## Quality Pass

For broad quality work, follow this sequence:

```text
system-patterns -> system-components -> surface-details -> surface-copy -> surface-interaction/surface-motion -> surface-colour/surface-typography
```

1. **system-patterns**: check whether the workflow is coherent, complete, and worth its complexity.
2. **system-components**: check whether shared components have complete state models and consistent contracts.
3. **surface-details**: remove platform friction, papercuts, unsafe hit areas, scroll problems, focus bugs, and implementation roughness.
4. **surface-copy**: clarify errors, empty states, helper text, loading text, and recovery language.
5. **surface-interaction/surface-motion**: make state changes spatially legible, interruptible, and appropriately quiet.
6. **surface-colour/surface-typography**: refine hierarchy, contrast, rhythm, and visual balance.

Stop as soon as the relevant domains have been covered. Quality work is not permission to inspect every skill by default.

---

## Coherence Rule

Every addition increases the number of relationships the interface must maintain. Before adding a feature, state:

- The existing pattern it extends.
- The user task it improves.
- The new states, transitions, permissions, errors, and empty cases it creates.
- The complexity it removes, hides, or justifies.

If the addition cannot answer those questions, it is probably feature accretion, not quality.

---

## Design-System Warning

A design system can preserve quality or mass-produce mediocrity. Component consistency is not enough. A quality review must include workflow coherence, state coverage, accessibility, copy, motion, platform behaviour, and visual finish.

Do not create a separate "quality" component, token, variant, or skill. Route each issue to the domain that can fix it.
