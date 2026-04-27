# Motion Polish Recipes

Use this reference when an animation technically works but still feels slightly wrong. Keep `SKILL.md` as the source of truth for core motion rules; use this file for review tactics, debugging checks, and reusable implementation recipes.

## Paired Motion

Elements that visually form one action should share timing and easing:

| Primary element | Paired element |
|---|---|
| Modal | Backdrop |
| Drawer | Scrim |
| Tooltip | Arrow |
| Popover | Arrow and trigger affordance |
| Toast | Stack displacement |

The paired element should begin with the primary element, but stay visually subordinate. A backdrop can fade in while a modal scales, but the backdrop should not have a more dramatic curve, longer duration, or stronger blur than the modal itself.

## Easing Strength

Use stronger curves when the motion needs more snap, not longer durations.

| Context | Subtle | Default | Strong |
|---|---|---|---|
| Ease out | `cubic-bezier(0.25, 0.46, 0.45, 0.94)` | `cubic-bezier(0.16, 1, 0.3, 1)` | `cubic-bezier(0.22, 1, 0.36, 1)` |
| Ease in out | `cubic-bezier(0.65, 0, 0.35, 1)` | `cubic-bezier(0.76, 0, 0.24, 1)` | `cubic-bezier(0.83, 0, 0.17, 1)` |
| Overshoot | Avoid by default | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Use only for emphasis |

If an animation feels slow, first try a stronger curve before increasing duration.

## CSS-Only Icon Swaps

If the project does not already use Motion, do not add a dependency only to animate icon swaps. Keep both icons mounted, position one absolutely, and cross-fade with opacity, scale, and a small blur.

```tsx
function IconSwap({ active, ActiveIcon, InactiveIcon }) {
  return (
    <span className="relative inline-grid place-items-center">
      <span
        aria-hidden
        className={cn(
          "absolute inset-0 grid place-items-center transition-[opacity,scale,filter] duration-200",
          active ? "scale-100 opacity-100 blur-0" : "scale-50 opacity-0 blur-[4px]"
        )}
      >
        <ActiveIcon />
      </span>
      <span
        aria-hidden
        className={cn(
          "grid place-items-center transition-[opacity,scale,filter] duration-200",
          active ? "scale-50 opacity-0 blur-[4px]" : "scale-100 opacity-100 blur-0"
        )}
      >
        <InactiveIcon />
      </span>
    </span>
  );
}
```

Use the same root dimensions for both icons so the button does not resize.

## Skip Default Mount Motion

For default-state UI, prevent an icon, tab marker, or toggle indicator from animating on first render. In Motion, use `initial={false}` on `AnimatePresence`.

```tsx
<AnimatePresence initial={false} mode="popLayout">
  <motion.span key={state} />
</AnimatePresence>
```

Do not use this on intentional entrance sequences such as page headers, onboarding steps, or staged loading states.

## Debugging

When motion feels wrong, record the interaction and scrub frame by frame. Check these in order:

1. Does the first frame jump because the starting style is missing?
2. Does the element move from the correct origin?
3. Does the paired element start and finish with it?
4. Is a layout property being animated instead of `transform`, `opacity`, or `filter`?
5. Is `transition: all` catching unintended properties?
6. Is a child resizing the parent during the animation?
7. Is the hover target moving under the pointer?

For hover flicker, animate a child wrapper while the parent remains the stable hit target.

## Review Checklist

- Paired elements share timing and easing.
- Secondary motion supports the primary action without competing.
- Default-state toggles and icon swaps do not animate on initial page load.
- CSS-only icon swaps are used when no motion library is already installed.
- Hover animations do not move the hit target itself.
- The problematic interaction has been inspected frame by frame when tuning by eye fails.
