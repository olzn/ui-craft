# Naming Taxonomy Reference

Load this reference when a task involves many names, a cross-surface audit, or a migration between Figma, code, docs, analytics, and product copy.

## Domain Patterns

| Domain | Primary shape | Good | Avoid |
|---|---|---|---|
| Button or command | Verb + object | `Create invoice`, `Delete project` | `Submit`, `OK`, `Do it` |
| Navigation | Destination noun | `Billing`, `Members`, `Reports` | `Go to billing`, `Manage` |
| Toggle | Setting noun | `Email notifications` | `Disable email notifications` as a static label |
| Component | Standard pattern noun | `Popover`, `Combobox`, `DataTable` | `MagicPanel`, `SearchySelect` |
| Compound part | Parent plus part | `Dialog.Title`, `Card.Footer` | `DialogHeaderTitleText` |
| Icon | Depicted glyph | `trash`, `lightbulb`, `chevron-left` | `delete`, `idea`, `back` as the only name |
| Primitive token | Value identity | `blue-500`, `space-4`, `radius-md` | `primary-blue`, `medium-space` |
| Semantic token | Role | `color-text-primary`, `space-gap-default` | `button-blue`, `grey-alt` |
| Component token | Component + property | `button-padding-x`, `card-shadow` | `primary-button-token` |
| CSS class | Object, role, or utility | `search-field`, `billing-summary`, `sr-only` | `blue-box`, `thing`, `new-style` |
| Variable | Held value | `selectedPlan`, `visibleColumns` | `data`, `obj`, `stuff` |
| Function | Verb phrase | `formatCurrency`, `fetchInvoices` | `currency`, `processor` |
| Boolean | State, possession, capability, policy | `open`, `hasErrors`, `canDelete`, `shouldRetry` | `isNotReady`, `disableRetry` |
| Feature | Descriptive capability | `Saved views`, `Bulk edit` | Branded names for minor functions |
| Product | Distinct branded offer | `Onym`, `Figma`, `Linear` | Generic words that fail search or legal checks |
| Figma layer | Object and role | `Header`, `Avatar image`, `Primary action` | `Group 47`, `Rectangle`, `New layer` |

## Token Name Grammar

Start broad, then narrow:

```text
{category}-{role}-{property}-{state}-{mode}
```

Use only the parts that add meaning.

```css
--color-text-primary
--color-surface-raised
--color-border-focus
--space-gap-default
--button-padding-x
--button-color-background-hover
```

Rules:

- Use primitives for raw value scales.
- Use semantics for product meaning.
- Use component tokens only for component-specific overrides.
- Put state after role or property: `hover`, `active`, `disabled`, `focus`.
- Put mode last when it is part of the name. Prefer theme remapping over names like `dark-text-primary`.

## Controlled Vocabulary Table

Use this format when naming drift is visible.

| Preferred term | Definition | Use for | Avoid | Aliases | Owner |
|---|---|---|---|---|---|
| `Dialog` | Blocking overlay for a focused task or decision | Component, docs | Modal, popup | Modal | component-craft |
| `Popover` | Anchored floating interactive content | Component, docs | Tooltip, flyout | Floating panel | component-craft |
| `Tooltip` | Short non-interactive help text | Component, docs | Popover | Help bubble | component-craft |
| `Toast` | Temporary low-priority feedback | Component, docs | Alert, snackbar | Snackbar | pattern-craft |
| `Alert` | Persistent status message | Component, docs | Toast | Banner | pattern-craft |

## Review Prompts

Ask these when reviewing a name:

- Who must understand this name: user, designer, engineer, support, or market?
- Does the name describe an object, action, state, role, or brand?
- Is the same concept named differently elsewhere?
- Would the name survive a visual redesign?
- Would the name survive a backend rewrite?
- Does it sort and search well?
- Does it translate or localise cleanly?
- Does it create legal, SEO, or category confusion?
- If renamed, what code, Figma, docs, analytics, and copy need migration?
