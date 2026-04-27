# Accessibility

Structured summary of accessibility requirements across the surface-craft and system-craft suites. This is a cross-reference guide, not a duplication of content. Each section points to the skill that owns the rules.

---

## Keyboard Navigation

**Ownership:** component-craft, detail-craft, pattern-craft

- Enter, Space, Escape, Arrow keys as appropriate per element type (component-craft)
- Tab order follows visual order (component-craft)
- Sequential lists use roving tabindex with `↑`/`↓` or `←`/`→` (detail-craft)
- `⌘+Backspace` deletes focused list items (detail-craft)
- Search results navigable with `↑`/`↓`, Enter selects (pattern-craft)
- Keyboard shortcut (`⌘K` or `/`) to focus search (pattern-craft)

---

## Focus Management

**Ownership:** component-craft, pattern-craft, detail-craft

- Visible focus ring on keyboard navigation (component-craft)
- Focus rings follow border-radius; use `box-shadow` for older Safari pre-16.4, `outline` with `outline-offset` on modern browsers (detail-craft)
- Modals trap focus; return focus to trigger on close (pattern-craft, component-craft)
- Hidden menus, closed drawers, inactive tab panels, and background pages behind modals leave the Tab order; use `inert` where supported (detail-craft)
- On submit error: scroll to first invalid field and focus it (pattern-craft)
- Multi-step forms validate each step on advancement (pattern-craft)

---

## Semantic HTML and ARIA

**Ownership:** component-craft, detail-craft

- Semantic HTML first; add ARIA only when native semantics are insufficient (component-craft)
- Every input has a `<label>` bound via `for`/`id` or wrapping (detail-craft)
- `aria-label` on every icon-only button, link, and toggle; naming-craft owns the label wording (detail-craft)
- Decorative icons get `aria-hidden="true"` (component-craft)
- Decorative HTML elements (illustrations, effects) get `aria-label` on their container (detail-craft)
- Images use `<img>` with `alt`, not `background-image` (detail-craft)
- Inputs live inside a `<form>` for Enter-to-submit (detail-craft)

---

## Colour and Contrast

**Ownership:** colour-craft

- All text meets WCAG 2.x AA (4.5:1 normal, 3:1 large) (colour-craft)
- Non-text UI elements meet 3:1 against adjacent colours (colour-craft)
- Contrast verified in both light and dark themes (colour-craft)
- Never use colour as the sole indicator of state; pair with icon, label, pattern, or position (colour-craft)
- Tested against all three colour vision deficiency types (colour-craft)
- APCA as secondary check for mid-tone edge cases (colour-craft)

---

## Motion

**Ownership:** motion-craft, detail-craft

- Respect `prefers-reduced-motion: reduce`; reduce to instant state changes, not disable entirely (motion-craft)
- Large `blur()` values reduced or removed under `prefers-reduced-motion` (detail-craft)
- No animation exceeds 400ms per individual element (motion-craft)

---

## Disabled States

**Ownership:** detail-craft, component-craft

- Disabled elements have inline explanation, not tooltip; disabled elements leave the tab order, so keyboard users never discover tooltips (detail-craft)
- Disabled state is visually muted and non-interactive (component-craft)
- Tooltips are informational only; no interactive content; use popover instead (detail-craft)

---

## Text and Selection

**Ownership:** detail-craft, type-craft

- `::selection` styled with brand colours (detail-craft)
- Gradient text readable when selected; unset `-webkit-background-clip` on `::selection` (detail-craft)
- `user-select: none` on interactive content (buttons, toggles, tabs, drag handles) to prevent accidental selection (detail-craft)
- `-webkit-text-size-adjust: 100%` to prevent iOS landscape resizing (type-craft)
- `text-wrap: balance` on headings, `text-wrap: pretty` on paragraphs (type-craft)

---

## Touch

**Ownership:** interaction-craft, detail-craft

- Hover styles scoped to `@media (hover: hover)` to prevent sticky hover on touch (detail-craft)
- Input font size minimum 16px to prevent iOS Safari auto-zoom (detail-craft)
- No auto-focus on touch devices; virtual keyboard covers half the screen (detail-craft)
- iOS tap highlight replaced with visible active/pressed state (detail-craft)
- Touch targets minimum 44px (interaction-craft, Fitts's Law)
- Small visible controls can extend hit areas with pseudo-elements, but expanded hit areas must not overlap (detail-craft)
- Custom gesture areas set `touch-action: none` (detail-craft)
- Fixed mobile UI respects `env(safe-area-inset-*)` (detail-craft)

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
