# Learnings

## `react-hook-form` `mode: "onTouched"` vs `"onBlur"`
**Context:** Choosing validation timing for medium-length forms with `react-hook-form`.
**Finding:** `mode: "onBlur"` validates when the field loses focus but does not re-validate on subsequent changes until the next blur. `mode: "onTouched"` validates on blur for the first interaction, then switches to `onChange` for that field, so errors clear as the user corrects them. This matches the "errors clear when the user corrects the input" rule without requiring manual configuration.
**Resolution:** Use `mode: "onTouched"` as the default for medium forms. Reserve `"onBlur"` for forms where real-time re-validation would be distracting (e.g. fields with expensive async validation).

## `nuqs` for URL state
**Context:** Reflecting filter, pagination, and modal state in the URL for deep linking.
**Finding:** `nuqs` provides type-safe URL search param management for Next.js with automatic serialisation, shallow routing by default, and support for complex param types (arrays, numbers, dates). It handles the "filters reflected in URL" requirement with minimal boilerplate compared to manual `useSearchParams` management.
**Resolution:** Prefer `nuqs` in Next.js projects for URL-synced state (search filters, pagination, tab selection, modal open state). For non-Next.js projects, evaluate framework-specific alternatives or use `URLSearchParams` directly.
