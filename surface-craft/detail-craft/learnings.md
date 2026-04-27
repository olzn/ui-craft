# Learnings

## `scrollbar-gutter: stable` for modal scroll lock
**Context:** Preventing layout shift when toggling `overflow: hidden` on the body for modal scroll lock.
**Finding:** `scrollbar-gutter: stable` reserves space for the scrollbar even when `overflow: hidden` is set, preventing the content from shifting when the scrollbar disappears. This eliminates the need for JavaScript-based scrollbar width compensation (measuring `window.innerWidth - document.documentElement.clientWidth` and adding padding).
**Resolution:** Set `scrollbar-gutter: stable` on `html` or `body` as a baseline. This handles classic scrollbars (Windows, Linux) cleanly. On macOS/iOS with overlay scrollbars, the property has no visible effect, so it's safe to apply universally.

## Radix Dialog focus return when trigger is removed
**Context:** A Radix Dialog whose trigger element is conditionally removed from the DOM while the dialog is open.
**Finding:** When a Radix Dialog closes, it attempts to return focus to the trigger element. If the trigger has been unmounted (e.g. the list item containing the trigger was deleted via the dialog), focus falls to the document body, which is a poor experience. Radix does not provide a built-in `onCloseAutoFocus` fallback target in all cases.
**Resolution:** Use the `onCloseAutoFocus` callback on `Dialog.Content` to programmatically redirect focus to a sensible alternative (e.g. the next list item, a parent container, or a heading) when the original trigger no longer exists.

## Next.js prefetch + iOS input zoom
**Context:** Next.js Link prefetch triggering layout shifts on iOS when navigating to pages with small inputs.
**Finding:** Next.js prefetches linked pages on viewport intersection. When the prefetched page renders inputs with `font-size` below 16px, iOS Safari's auto-zoom fires immediately on navigation, causing a jarring zoom-in. The zoom happens before the user interacts with any input because the page renders at the prefetched state.
**Resolution:** Enforce the 16px minimum input font size globally. This is the root fix. Additionally, set `maximum-scale=1` in the viewport meta tag as a defence-in-depth measure, but note this also disables pinch-to-zoom, which is an accessibility regression; use with caution.
