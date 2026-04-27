# Component API Polish

Use this reference when a component works but its API feels awkward, overfitted, or too loose. `SKILL.md` owns the required conventions; this file helps with judgement calls.

## Goldilocks Customisability

A component API should be neither rigid nor infinitely configurable.

| Too rigid | Balanced | Too loose |
|---|---|---|
| One-off content props for every case | Props for finite variants, composition for structure | Arbitrary style and render props for everything |
| Forces consumers to fork the component | Lets consumers express real product needs | Makes every usage re-implement the component |
| Breaks at the fourth variation | Holds stable across common variations | Has no consistent design system behaviour |

Use props for finite, design-system-controlled choices such as `variant`, `size`, `tone`, and `disabled`. Use composition when the consumer needs to control content order, nested structure, or multiple actions.

## Button Defaults

Button components must default to `type="button"`. Native `<button>` defaults to submit inside a form, which causes accidental form submissions.

```tsx
function Button({ type = "button", ...props }: ButtonProps) {
  return <button type={type} {...props} />;
}
```

Use `type="submit"` only when the button is explicitly the form submit action.

## Error Boundaries

Complex data components should have an error strategy:

- Accept an `error` state and render a recovery action.
- Allow a caller-provided fallback for complex panels.
- Use app-level error boundaries for render failures that cannot be represented as normal component state.

Do not hide render errors behind an empty state. Empty means there is no data; error means the intended data could not be loaded or rendered.

## Promotion Rule

Do not promote every repeated JSX block into the design system. Promote a component when at least one is true:

- The pattern appears in 2-3 places and must stay visually consistent.
- The behaviour is accessibility-sensitive.
- The API represents a foundation primitive such as Button, Dialog, Menu, Select, or Tabs.
- The implementation is easy to get wrong and worth centralising.

Leave one-off product layouts local until their shape stabilises.

## File Shape

For non-trivial components, keep structure predictable:

```text
button/
├── button.tsx
├── button.variants.ts
├── button.test.tsx
└── index.ts
```

Keep variant maps separate once they become large. Export public components from `index.ts`; keep internal helpers private.

## Review Checklist

- The component defaults to safe native behaviour.
- Finite design choices are props; structural variation is composition.
- The API avoids both one-off content props and unbounded style escape hatches.
- Error, empty, and loading states are not conflated.
- Promotion into the shared system is justified by reuse, risk, or foundation status.
- File shape is predictable for non-trivial components.
