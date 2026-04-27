# Accessibility

Structured summary of accessibility requirements across the surface and system suites. This is a cross-reference guide, not a duplication of content. Each section points to the skill that owns the rules.

---

## Keyboard Navigation

**Ownership:** system-components, surface-details, system-patterns

- Enter, Space, Escape, Arrow keys as appropriate per element type (system-components)
- Tab order follows visual order (system-components)
- Sequential lists use roving tabindex with `↑`/`↓` or `←`/`→` (surface-details)
- `⌘+Backspace` deletes focused list items (surface-details)
- Search results navigable with `↑`/`↓`, Enter selects (system-patterns)
- Keyboard shortcut (`⌘K` or `/`) to focus search (system-patterns)

---

## Focus Management

**Ownership:** system-components, system-patterns, surface-details

- Visible focus ring on keyboard navigation (system-components)
- Focus rings follow border-radius; use `box-shadow` for older Safari pre-16.4, `outline` with `outline-offset` on modern browsers (surface-details)
- Modals trap focus; return focus to trigger on close (system-patterns, system-components)
- Hidden menus, closed drawers, inactive tab panels, and background pages behind modals leave the Tab order; use `inert` where supported (surface-details)
- On submit error: scroll to first invalid field and focus it (system-patterns)
- Multi-step forms validate each step on advancement (system-patterns)

---

## Semantic HTML and ARIA

**Ownership:** system-components, surface-details

- Semantic HTML first; add ARIA only when native semantics are insufficient (system-components)
- Every input has a `<label>` bound via `for`/`id` or wrapping (surface-details)
- `aria-label` on every icon-only button, link, and toggle; system-naming owns the label wording (surface-details)
- Decorative icons get `aria-hidden="true"` (system-components)
- Decorative HTML elements (illustrations, effects) get `aria-label` on their container (surface-details)
- Images use `<img>` with `alt`, not `background-image` (surface-details)
- Inputs live inside a `<form>` for Enter-to-submit (surface-details)

---

## Colour and Contrast

**Ownership:** surface-colour

- All text meets WCAG 2.x AA (4.5:1 normal, 3:1 large) (surface-colour)
- Non-text UI elements meet 3:1 against adjacent colours (surface-colour)
- Contrast verified in both light and dark themes (surface-colour)
- Never use colour as the sole indicator of state; pair with icon, label, pattern, or position (surface-colour)
- Tested against all three colour vision deficiency types (surface-colour)
- APCA as secondary check for mid-tone edge cases (surface-colour)

---

## Motion

**Ownership:** surface-motion, surface-details

- Respect `prefers-reduced-motion: reduce`; reduce to instant state changes, not disable entirely (surface-motion)
- Large `blur()` values reduced or removed under `prefers-reduced-motion` (surface-details)
- No animation exceeds 400ms per individual element (surface-motion)

---

## Disabled States

**Ownership:** surface-details, system-components

- Disabled elements have inline explanation, not tooltip; disabled elements leave the tab order, so keyboard users never discover tooltips (surface-details)
- Disabled state is visually muted and non-interactive (system-components)
- Tooltips are informational only; no interactive content; use popover instead (surface-details)

---

## Text and Selection

**Ownership:** surface-details, surface-typography

- `::selection` styled with brand colours (surface-details)
- Gradient text readable when selected; unset `-webkit-background-clip` on `::selection` (surface-details)
- `user-select: none` on interactive content (buttons, toggles, tabs, drag handles) to prevent accidental selection (surface-details)
- `-webkit-text-size-adjust: 100%` to prevent iOS landscape resizing (surface-typography)
- `text-wrap: balance` on headings, `text-wrap: pretty` on paragraphs (surface-typography)

---

## Touch

**Ownership:** surface-interaction, surface-details

- Hover styles scoped to `@media (hover: hover)` to prevent sticky hover on touch (surface-details)
- Input font size minimum 16px to prevent iOS Safari auto-zoom (surface-details)
- No auto-focus on touch devices; virtual keyboard covers half the screen (surface-details)
- iOS tap highlight replaced with visible active/pressed state (surface-details)
- Touch targets minimum 44px (surface-interaction, Fitts's Law)
- Small visible controls can extend hit areas with pseudo-elements, but expanded hit areas must not overlap (surface-details)
- Custom gesture areas set `touch-action: none` (surface-details)
- Fixed mobile UI respects `env(safe-area-inset-*)` (surface-details)

---

## Combined Verification Checklist

### Keyboard
- [ ] Every interactive element reachable via Tab
- [ ] Enter/Space activate buttons and links
- [ ] Escape closes overlays and modals
- [ ] Arrow keys navigate sequential lists
- [ ] Focus ring visible on every focusable element
- [ ] Focus rings follow border-radius
- [ ] Modal focus traps and returns on close
- [ ] Inactive regions are not reachable via Tab
- [ ] Search supports keyboard navigation

### Vision
- [ ] All text meets WCAG 2.x AA contrast
- [ ] UI elements meet 3:1 contrast
- [ ] No state relies on colour alone
- [ ] Colour blindness tested (all three types)
- [ ] Contrast verified in both themes
- [ ] `::selection` styled and readable
- [ ] Gradient text readable when selected
- [ ] `prefers-reduced-motion` respected

### Screen Reader
- [ ] Semantic HTML used (headings, landmarks, lists)
- [ ] Labels on all inputs
- [ ] `aria-label` on icon-only buttons
- [ ] `aria-hidden` on decorative icons
- [ ] Images use `<img>` with `alt`
- [ ] Disabled states explained inline
- [ ] Tooltips are informational only

### Touch
- [ ] Hover scoped to pointer devices
- [ ] Input font ≥ 16px
- [ ] No auto-focus on touch
- [ ] Touch targets ≥ 44px
- [ ] Expanded hit areas do not overlap
- [ ] iOS tap highlight replaced
- [ ] Custom gesture areas set `touch-action`
- [ ] Fixed UI respects safe-area insets
