# Learnings

## OKLCH gamut clamping hue shift on sRGB displays
**Context:** Using high-chroma OKLCH values that exceed the sRGB gamut on standard displays.
**Finding:** When an OKLCH colour exceeds the sRGB gamut, browsers clamp it to the nearest in-gamut colour. The clamping algorithm can shift the hue noticeably; a vivid cyan may clamp to a bluer shade, and saturated oranges may shift toward red. This means the displayed colour can differ from the intended hue, not just the chroma.
**Resolution:** For critical colours (brand, status indicators, text), verify the OKLCH value is within sRGB gamut using OKLCH.fyi or browser DevTools. Reserve out-of-gamut values for decorative/accent uses where a slight hue shift is acceptable on sRGB displays.

## `color-contrast()` not yet shipped
**Context:** Attempting to use `color-contrast()` to automatically select accessible text colours against variable backgrounds.
**Finding:** `color-contrast()` is specified in CSS Color Level 5 but has not shipped in any browser as of early 2026. It was briefly available behind a flag in Safari but was removed. There is no reliable CSS-only way to auto-select a contrasting text colour at runtime.
**Resolution:** Continue using manual semantic token mapping for text-on-surface pairs. For dynamic backgrounds (user-selected colours), calculate contrast on the server or in JavaScript and set a CSS variable. Revisit `color-contrast()` when browser support materialises.
