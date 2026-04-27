# Interface Polish Recipes

Use this reference for small implementation details that make a working interface feel deliberate. These rules belong to the detail layer, not the component API or token architecture.

## Hit Areas

Interactive targets should be at least 44px where practical, and never smaller than 40px without a deliberate exception. If the visible control is smaller, extend the hit area with a pseudo-element.

```css
.icon-button {
  position: relative;
}

.icon-button::after {
  content: "";
  position: absolute;
  inset: 50% auto auto 50%;
  width: 44px;
  height: 44px;
  transform: translate(-50%, -50%);
}
```

Expanded hit areas must not overlap. If two controls are close together, reduce the pseudo-element or increase spacing so each pixel belongs to only one action.

## Safe Areas

Fixed UI must respect device safe areas:

```css
.bottom-bar {
  padding-bottom: max(1rem, env(safe-area-inset-bottom));
}

.top-bar {
  padding-top: max(0.75rem, env(safe-area-inset-top));
}
```

Apply this to bottom navigation, mobile toolbars, sheets, toasts, floating action buttons, and any fixed header that can sit under a notch or browser chrome.

## Hairline Separators

Use hairlines for dense separators and shadow rings for elevated surfaces. Do not replace table borders, dividers, or input outlines with elevation shadows.

```css
:root {
  --border-hairline: 1px;
}

@media (min-resolution: 2dppx) {
  :root {
    --border-hairline: 0.5px;
  }
}
```

Use sparingly. A page full of hairlines reads as visual noise.

## Image Outlines

Image outlines should be neutral separators:

```css
.image {
  outline: 1px solid rgba(0, 0, 0, 0.1);
  outline-offset: -1px;
}

.dark .image {
  outline-color: rgba(255, 255, 255, 0.1);
}
```

Use pure black or pure white alpha. Avoid tinted neutral scales for image outlines because they can make the edge look dirty against the image content.

## Text Overflow

Prevent text from resizing dense UI:

```css
.grid-row {
  grid-template-columns: minmax(0, 1fr) auto;
}

.title {
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
```

For cards and descriptions, prefer `line-clamp` over letting one long item change the whole grid height.

## Hydration and Theme Flash

The first rendered state, hydrated state, and persisted state should match. Theme, density, sidebar collapse, and locale should not visibly flash after load.

- Read persisted theme before paint when possible.
- Suppress transitions during theme changes.
- Avoid rendering a signed-out shell before an authenticated redirect.
- Use skeletons that match final dimensions to prevent layout jumps.

## Shortcuts and Platform Labels

Show shortcuts using the user's platform conventions: `Cmd` on macOS, `Ctrl` elsewhere. If a shortcut is attached to an icon-only button, expose the shortcut in the tooltip or accessible description, but keep the button label focused on the action.

## Inactive Regions

When a modal, drawer, or overlay makes the page behind it inactive, use focus trapping and mark unavailable regions with `inert` where supported. Hidden panels, closed menus, and inactive tab panels should not remain in the Tab order.

## Review Checklist

- Small visible controls have expanded hit areas.
- Expanded hit areas do not overlap.
- Fixed mobile UI respects safe-area insets.
- Dense separators use hairlines, elevated surfaces use shadows.
- Image outlines use pure black or white alpha.
- Long text cannot resize controls or break grid tracks.
- Persisted UI state does not flash after hydration.
- Keyboard shortcut labels match the user's platform.
- Inactive regions are removed from focus navigation.
