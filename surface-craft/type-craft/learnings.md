# Learnings

## Fontaine for auto-generating metric overrides
**Context:** Configuring `size-adjust`, `ascent-override`, `descent-override`, and `line-gap-override` to minimise layout shift on font swap.
**Finding:** Manually computing metric overrides is error-prone. The `fontaine` package (by the Nuxt team) auto-generates `@font-face` declarations with accurate metric overrides for any Google Font or local font file. It integrates as a Vite/webpack plugin.
**Resolution:** Use `fontaine` to generate metric overrides automatically. Verify the output visually; some fonts with unusual metrics may need manual adjustment after auto-generation.

## `text-wrap: balance` performance on long text
**Context:** Applying `text-wrap: balance` to paragraph elements.
**Finding:** `text-wrap: balance` is designed for short text (headings, captions). When applied to long paragraphs, the browser's balancing algorithm scans the entire text block and can cause noticeable layout jank on initial render, especially with dynamic content. Chrome limits `balance` to 6 lines; content beyond that falls back to normal wrapping.
**Resolution:** Apply `text-wrap: balance` only to headings and short text elements (4-6 lines max). Use `text-wrap: pretty` for paragraphs; it optimises line breaks without the performance cost of full balancing.
