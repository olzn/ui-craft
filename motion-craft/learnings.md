# Learnings

## Motion v12 layout animation flash fix
**Context:** Layout animations in Motion (Framer Motion) v12 producing a flash of the element at its final position before the animation starts.
**Finding:** Motion v12 changed the timing of layout effect measurements. Components using `layout` or `layoutId` can flash at their destination before animating from the source. The fix is to set `style={{ opacity: 0 }}` and let `initial={{ opacity: 0 }}` / `animate={{ opacity: 1 }}` handle visibility, or use `layoutDependency` to control when measurements occur.
**Resolution:** When layout animations flash in Motion v12+, add explicit opacity control to hide the element until the animation system takes over. Test layout animations after any Motion major version upgrade.

## `@starting-style` Safari bug with `display: none`
**Context:** Using `@starting-style` for CSS-only enter animations on elements toggled via `display: none` / `display: block`.
**Finding:** Safari 17.5-17.6 does not apply `@starting-style` when transitioning from `display: none`. The element appears at its final state with no transition. Chrome and Firefox handle this correctly. Safari 18+ fixes the issue.
**Resolution:** For Safari 17.x support, use the `useEffect` + data-attribute pattern or `visibility`/`opacity` instead of `display: none`. For Safari 18+, `@starting-style` works reliably.

## Spring `bounce` vs raw `stiffness`/`damping`
**Context:** Configuring spring animations in Motion — choosing between the `bounce` shorthand and raw physics values.
**Finding:** Motion's `bounce` parameter (0 = no bounce, 1 = max bounce) is easier to tune than raw `stiffness`/`damping` pairs. `bounce: 0` with a `duration` produces a smooth settle identical to a critically damped spring. `bounce: 0.25` gives a subtle overshoot. Raw values are still needed when matching a specific physics simulation or when `bounce` doesn't provide enough control.
**Resolution:** Default to `bounce` + `duration` for most UI springs. Only use raw `stiffness`/`damping`/`mass` when precision physics are required or when matching an existing specification.
