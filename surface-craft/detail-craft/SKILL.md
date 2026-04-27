---
name: detail-craft
description: Catch platform-specific implementation details and visual polish that make web interfaces feel professional. Use when building forms, inputs, toggles, buttons, dropdowns, scroll behaviour, touch interfaces, focus handling, or production polish. Also triggers for bugs like iOS input zoom, sticky hover on mobile, dead zones, tooltip delay, menu prediction cones, unsafe hit areas, hydration flash, image outlines, optical alignment, shadow depth, nested radius, and performance micro-issues. Does NOT cover animation values or easing (use motion-craft), gesture decisions (use interaction-craft), type systems (use type-craft), colour or contrast (use colour-craft), component APIs (use component-craft), or token architecture (use token-craft).
---

# Detail Craft

Platform-specific implementation details and visual polish that separate professional web interfaces from amateur ones. Based on the [Web Interface Guidelines](https://interfaces.rauno.me) by Rauno Freiberg and the [interface details](https://jakub.kr/writing/details-that-make-interfaces-feel-better) work of Jakub Królikowski.

This skill fires during construction of interactive elements and when debugging platform behaviour. It is deliberately granular: a list of specific, testable details. For design philosophy, see `design-philosophy.md`. For animation implementation, see **motion-craft**. For accessibility across all skills, see `accessibility.md`. For multi-skill task sequencing, see `composition.md`.

For expanded hit areas, safe-area insets, hairline separators, text overflow, hydration flash, platform shortcut labels, and inert inactive regions, read `references/interface-polish.md`.

---

## Forms and Inputs

**Labels focus inputs.** Every input has a `<label>` bound via `for`/`id` or wrapping. Clicking the label focuses the input.

**Inputs live inside a `<form>`.** Even single-input UIs. This enables Enter to submit.

**Set the correct `type`.** `email`, `password`, `tel`, `url`, `search`, `number`. This controls the mobile keyboard layout. The wrong type means the wrong keyboard.

**Disable `spellcheck` by default on most inputs.** Only enable where prose is expected (textareas, rich text editors). Leave `autocomplete` enabled by default. Users with motor and cognitive disabilities, and anyone using a password manager, depend on it. Disable `autocomplete` only on specific fields where the browser's suggestions are misleading (e.g. a field labelled "email" that asks for someone else's email, or a one-time code input).

**Use the `required` attribute.** HTML validation before JavaScript validation. The browser handles it for free.

**Position input decorations on top.** Icons, currency symbols, and prefix/suffix elements should be absolutely positioned over the input with corresponding padding. Never place them as adjacent siblings. Clicking the decoration must focus the input.

```css
.input-wrapper {
  position: relative;
}

.input-icon {
  position: absolute;
  left: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
}

.input-field {
  padding-left: 2.5rem;
}
```

---

## Toggles, Buttons, and Interactive Elements

**Toggles take effect immediately.** Never require a separate confirmation step for a toggle. If toggling triggers a network request, show a loading state on the toggle itself.

**Disable buttons after submission.** Prevents duplicate network requests. Re-enable on success or failure.

**`user-select: none` on interactive content.** Prevents accidental text selection during clicks, drags, and taps. Apply to the inner content of buttons, toggles, tabs, and drag handles.

**`pointer-events: none` on decorative elements.** Glows, gradients, particle effects, and overlays must not intercept clicks or hover events.

**No dead zones between list items.** In a list of clickable items, increase `padding` to fill the space rather than using `margin` or `gap`. Every pixel between items should be clickable by one of them.

```css
/* Wrong: gap creates unclickable dead zones */
.list { display: flex; flex-direction: column; gap: 8px; }
.list-item { padding: 8px; }

/* Right: padding fills the space */
.list { display: flex; flex-direction: column; }
.list-item { padding: 12px; }  /* extra padding absorbs the gap */
```

**Extend small hit areas.** Icon buttons, checkboxes, and drag handles that are visually smaller than 44px need a pseudo-element or wrapping label to enlarge the target. Expanded hit areas must not overlap neighbouring controls.

---

## Dropdown and Context Menus

**Open on `mousedown`, not `click`.** `click` waits for both press and release, adding ~100ms of perceived latency. `mousedown` fires on press, making menus feel instant.

**Prediction cone for nested menus.** When a top-level menu item reveals a submenu, the user moves the pointer diagonally toward it. Without a prediction cone (safe triangle), the pointer crosses other menu items and triggers their submenus instead, closing the intended one. Implement a triangular hit area between the current pointer position and the submenu bounds.

---

## Tooltips

**Skip delay on subsequent tooltips.** Tooltips should have a slight delay (200-300ms) before appearing to prevent accidental activation. But once a tooltip is open, hovering over another tooltip trigger should show it immediately with no delay and no animation. This feels faster without defeating the purpose of the initial delay.

Radix and Base UI handle the delay skipping automatically. Base UI also supports skipping the animation via the `data-instant` attribute:

```css
.tooltip {
  transition: transform 125ms ease-out, opacity 125ms ease-out;
  transform-origin: var(--transform-origin);
}

.tooltip[data-starting-style],
.tooltip[data-ending-style] {
  opacity: 0;
  transform: scale(0.97);
}

/* Skip animation on subsequent tooltips */
.tooltip[data-instant] {
  transition-duration: 0ms;
}
```

---

## Touch

**Scope hover styles to pointer devices.**

```css
@media (hover: hover) {
  .button:hover { background: var(--color-surface-hover); }
}
```

Without this, touch devices show a persistent "sticky hover" state after tap.

**Input font size minimum 16px.** Any `<input>` or `<textarea>` with `font-size` below 16px triggers automatic page zoom on focus in iOS Safari. This is the single most common mobile bug.

**Never auto-focus inputs on touch devices.** Auto-focus opens the virtual keyboard immediately, covering half the screen before the user has oriented themselves. On desktop, auto-focus is fine.

**Video autoplay on iOS.** Add `muted` and `playsinline` attributes to `<video>` tags. Without both, autoplay will not work.

```html
<video autoplay muted playsinline loop>
  <source src="hero.mp4" type="video/mp4">
</video>
```

**Disable native gestures on custom gesture areas.** For components with custom pan, pinch, or zoom behaviour, set `touch-action: none` to prevent the browser's native gestures from interfering.

**Replace the iOS tap highlight.** Disable the default with `-webkit-tap-highlight-color: transparent`, but always add a visible active/pressed state as replacement. Removing the highlight without an alternative is an accessibility regression.

**Respect safe areas.** Fixed mobile UI uses `env(safe-area-inset-*)` so bottom bars, toasts, drawers, and floating actions do not collide with notches, home indicators, or browser chrome.

---

## Scroll

**Smooth scroll for anchors.**

```css
html { scroll-behavior: smooth; }

[id] { scroll-margin-top: 5rem; }  /* account for fixed header */
```

**Pause off-screen loops.** Looping animations (CSS or JS) and auto-playing videos should pause when scrolled out of view. Use `IntersectionObserver` to detect visibility. This saves CPU and GPU.

---

## Performance

**Large `blur()` values are expensive.** `filter: blur()` and `backdrop-filter: blur()` with high values (20px+) cause visible performance drops on lower-end devices. Test on real hardware. Reduce or remove blur on `prefers-reduced-motion: reduce`.

**Blurred rectangles cause banding.** Scaling and blurring a solid-colour rectangle produces visible colour banding. Use `radial-gradient` instead.

**GPU compositing as last resort.** `transform: translateZ(0)` forces GPU compositing and can fix janky animations. But apply it sparingly and only to the specific element. Pre-emptively adding it to many elements wastes GPU memory.

**`will-change` only during animation.** Apply `will-change` for the duration of an active animation, then remove it. Adding it permanently to static elements reserves GPU resources for nothing and can make performance worse.

**Limit concurrent videos on iOS.** Auto-playing too many `<video>` elements simultaneously chokes iOS devices. Pause or unmount videos that scroll out of view.

**Bypass React rendering for real-time values.** For scroll position, pointer coordinates, and animation frames, track values in a `ref` and write directly to the DOM. Pushing high-frequency updates through React state causes unnecessary re-renders.

```tsx
const scrollY = useRef(0);

useEffect(() => {
  const handler = () => {
    scrollY.current = window.scrollY;
    elementRef.current.style.transform = `translateY(${scrollY.current * 0.5}px)`;
  };
  window.addEventListener('scroll', handler, { passive: true });
  return () => window.removeEventListener('scroll', handler);
}, []);
```

---

## Accessibility Micro-Details

**Disabled buttons have no tooltips.** Disabled elements are removed from the tab order. Screen reader and keyboard users will never discover the tooltip. Show inline text explaining why the button is disabled instead.

**Focus rings follow border-radius.** Use `box-shadow` for custom focus rings if you need to support older Safari (pre-16.4) where `outline` ignores radius. On modern browsers, `outline` with `outline-offset` works.

**Inactive regions leave focus navigation.** Hidden menus, closed drawers, inactive tab panels, and background pages behind modals should not remain reachable by Tab. Use focus trapping for modals and `inert` where supported.

**Arrow keys navigate sequential lists.** Focusable elements in a vertical list support `↑`/`↓` navigation (roving tabindex). In a horizontal list, `←`/`→`.

**`⌘+Backspace` deletes in lists.** Keyboard users expect to delete a focused list item without reaching for a button.

**`aria-label` on icon-only elements.** Every icon button, icon link, and icon toggle needs an explicit label. Use naming-craft when choosing the label text.

**Tooltips are informational only.** Hover-triggered tooltips must not contain interactive content (links, buttons). Interactive content goes in a popover.

**Images use `<img>`, not `background-image`.** Screen readers can access `<img>` with `alt` text. `background-image` is invisible to assistive tech and cannot be right-click copied.

**Decorative HTML gets `aria-label`.** Complex decorative elements built from HTML (illustrations, visual effects) should have `aria-label` on their container so screen readers announce the intent, not the raw DOM structure.

**Gradient text selection.**

```css
.gradient-text::selection {
  -webkit-background-clip: unset;
  background: var(--color-selection);
  color: var(--color-on-selection);
}
```

Without this, selecting gradient text produces unreadable results.

---

## Implementation Patterns

**Optimistic updates.** Update the UI immediately on action. Roll back with feedback if the server errors. Never show a spinner for actions that succeed 99% of the time.

**Server-side auth redirects.** Authentication redirects happen before the client renders. Client-side redirects cause a flash of the wrong page and a janky URL change.

**Style `::selection`.**

```css
::selection {
  background: var(--color-brand);
  color: var(--color-on-brand);
}
```

**Feedback near its trigger.** A copy button shows an inline checkmark, not a toast. Form errors highlight the specific invalid inputs, not a banner at the top. Feedback is always spatially associated with the action that caused it.

**Designed empty states.** An empty list prompts the user to create their first item. Include a call-to-action and, where appropriate, templates or starting examples.

**Theme switching without transition flash.** Toggling between light and dark mode must temporarily disable CSS transitions to prevent every element on screen from visibly transitioning. Re-enable transitions after the switch. Libraries like `next-themes` handle this automatically.

**Pause timers when the tab is hidden.** Auto-dismissing elements (toasts, banners, notifications) should pause their timers when `document.hidden` is true. If a toast fires and the user is in another tab, the toast should still be visible when they return. Use the `visibilitychange` event to pause and resume.

**Fill hover gaps with pseudo-elements.** When interactive elements have gaps between them (stacked toasts, spaced cards), hovering between items triggers a mouseout. Add `::after` pseudo-elements to fill the gaps so the hover state is maintained across the group.

**Maintain pointer capture during drag.** When a user drags an element (a toast, a slider thumb, a card), set pointer capture on `pointerdown` so the element continues receiving events even if the pointer leaves its bounds. Without this, fast drags lose tracking when the cursor escapes the element.

---

## Visual Polish

**Concentric border radius.** When nesting a rounded element inside a rounded container, the outer radius must equal the inner radius plus the padding between them. Mismatched radii are one of the most visible signs of careless UI work.

```css
/* outer radius = inner radius + padding */
.card       { border-radius: 20px; padding: 8px; }
.card-inner { border-radius: 12px; }  /* 20 - 8 = 12 */
```

If the padding changes, the inner radius must change with it. This relationship is not optional.

**Optical alignment over geometric alignment.** Geometric centering (equal padding on all sides) sometimes looks visually unbalanced. When an element contains both text and an icon, the icon side typically needs less padding than the text side to appear optically centred.

```css
/* Geometric: equal padding, looks off */
.button { padding: 0 16px; }

/* Optical: less padding on the icon side */
.button-with-leading-icon  { padding: 0 16px 0 12px; }
.button-with-trailing-icon { padding: 0 12px 0 16px; }
```

Play/arrow icons are the worst offenders. If alignment looks wrong despite correct measurements, trust the eye and adjust by 2-4px.

**Box-shadow instead of borders.** A subtle multi-layered `box-shadow` produces more depth and visual refinement than a `1px solid` border, particularly in light mode. Shadows adapt better to varied backgrounds because they use transparency.

Use token-craft's shadow scale (`--shadow-sm` through `--shadow-xl`) based on the Derek Briggs method. See token-craft for the full scale definition and method explanation.

```css
.card {
  box-shadow: var(--shadow-lg);
}
```

For hover states, step up one level in the scale or slightly increase the opacity (e.g. 0.06 to 0.08). Add `transition: box-shadow` to animate between states.

**Image outline for depth.** A `1px` semi-transparent outline on images creates a subtle sense of containment and depth, particularly in design systems where other elements also have borders.

```css
.image {
  outline: 1px solid rgba(0, 0, 0, 0.1);
  outline-offset: -1px;
}

.dark .image {
  outline-color: rgba(255, 255, 255, 0.1);
}
```

---

## Anti-Patterns

1. **iOS input zoom.** Input font size below 16px. The single most common mobile bug.
2. **Sticky hover on touch.** Not using `@media (hover: hover)`.
3. **Dead zones in lists.** Margin or gap instead of padding between clickable items.
4. **Auto-focus on mobile.** Opening the keyboard before the user is ready.
5. **Toast for important feedback.** Copy confirmation, form success, and errors should be inline.
6. **`will-change` on everything.** Wastes GPU memory and can reduce performance.
7. **Outline focus rings on rounded elements.** Outline doesn't follow radius in older browsers.
8. **Disabled button with tooltip.** Keyboard users will never see it.
9. **Mismatched nested border radii.** Inner and outer radius are the same value instead of outer = inner + padding.
10. **Geometric alignment with icons.** Equal padding on a button with an icon. The icon side needs less padding to look centred.

---

## Checklist

### Inputs
- Labels focus their input
- Inputs inside a `<form>`
- Correct `type` attributes
- Decorations positioned on top, not adjacent
- Font size at least 16px (iOS zoom)

### Touch
- Hover scoped to `@media (hover: hover)`
- iOS tap highlight replaced with active state
- No auto-focus on touch devices
- Videos have `muted playsinline`
- Custom gesture areas set `touch-action: none`

### Performance
- Off-screen videos and loops paused
- `will-change` only during active animation
- Large blur tested on real hardware
- Real-time values use refs, not state

### Accessibility
- Disabled buttons have inline explanation, not tooltip
- Focus rings visible and follow radius
- Inactive regions are not reachable by Tab
- Icon-only buttons have `aria-label`
- Arrow key navigation in sequential lists
- `::selection` styled
- Gradient text readable when selected

### Implementation
- Optimistic updates with rollback
- Auth redirects server-side
- Empty states prompt creation
- Feedback inline near trigger
- Theme switching suppresses transitions
- Persisted UI state does not flash after hydration
- Auto-dismiss timers pause when tab is hidden
- Hover gaps filled with pseudo-elements
- Pointer capture set on drag start

### Tooltips
- Initial delay before first tooltip (200-300ms)
- Subsequent tooltips skip delay and animation

### Visual Polish
- Nested border radii are concentric (outer = inner + padding)
- Buttons with icons use optical alignment (reduced padding on icon side)
- Cards use multi-layered box-shadow for depth, not flat borders
- Images have a subtle pure black or white alpha outline for containment
- Fixed mobile UI respects safe-area insets

---

## Learning from Usage

After completing a UI implementation task, review the output against the checklist. Append findings to `learnings.md` in this skill's folder. Consult `learnings.md` before starting any new task.
