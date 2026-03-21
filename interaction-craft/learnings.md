# Learnings

## `scroll-snap-type` vs custom swipe gesture conflict
**Context:** Implementing custom swipe-to-dismiss on an element inside a `scroll-snap` container.
**Finding:** CSS `scroll-snap-type` and JavaScript-driven swipe gestures compete for the same touch events. The browser's scroll snap consumes the gesture before the JavaScript handler can evaluate intent. Setting `touch-action: none` on the swipeable element prevents scroll snap from capturing the gesture, but also disables native scrolling on that element entirely.
**Resolution:** Isolate swipeable elements from scroll-snap containers. Either remove the swipeable element from the snap container's DOM, or use `touch-action: pan-y` (for horizontal swipe) / `touch-action: pan-x` (for vertical swipe) to allow one axis of native scrolling while capturing the other axis for the custom gesture.

## iOS Safari rubber-band vs `overscroll-behavior`
**Context:** Preventing scroll chaining in modals and drawers on iOS Safari.
**Finding:** `overscroll-behavior: contain` prevents scroll chaining on Chrome and Firefox, but iOS Safari (through 17.x) does not fully support it. The rubber-band overscroll effect still bleeds through to the body, causing the background page to bounce when the user scrolls past the end of modal content.
**Resolution:** On iOS Safari, combine `overscroll-behavior: contain` with a JavaScript scroll lock (e.g. `body-scroll-lock` or setting `position: fixed` on the body with scroll position compensation). Test on real iOS devices — the simulator does not reproduce the rubber-band behaviour accurately.
