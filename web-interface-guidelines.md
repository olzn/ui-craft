---
name: web-interface-guidelines
description: Apply when building web interfaces, UI components, or reviewing interaction patterns. Use for: interactivity patterns (forms, inputs, buttons, toggles), typography implementation (font rendering, weights, responsive sizing), motion and animation (transitions, durations, performance), touch device optimization (iOS behaviors, gesture handling), performance optimization (GPU rendering, scroll performance, video handling), accessibility (focus states, ARIA, screen readers, keyboard navigation), and design patterns (empty states, feedback, authentication flows). Trigger when creating React/HTML components, implementing user interactions, optimizing web performance, or ensuring accessible interfaces.
---

# Web Interface Guidelines

A non-exhaustive list of details that make a good web interface. Based on [Rauno Freiberg's guidelines](https://github.com/raunofreiberg/interfaces).

## Related Skills

For conceptual understanding of why interactions work (gesture thresholds, motion principles, spatial consistency), see the `interaction-design-principles` skill.

## Interactivity

* Clicking the input label should focus the input field
* Inputs should be wrapped with a `<form>` to submit by pressing Enter
* Inputs should have an appropriate `type` like `password`, `email`, etc
* Inputs should disable `spellcheck` and `autocomplete` attributes most of the time
* Inputs should leverage HTML form validation by using the `required` attribute when appropriate
* Input prefix and suffix decorations, such as icons, should be absolutely positioned on top of the text input with padding, not next to it, and trigger focus on the input
* Toggles should immediately take effect, not require confirmation
* Buttons should be disabled after submission to avoid duplicate network requests
* Interactive elements should disable `user-select` for inner content
* Decorative elements (glows, gradients) should disable `pointer-events` to not hijack events
* Interactive elements in a vertical or horizontal list should have no dead areas between each element, instead, increase their `padding`

## Typography

* Fonts should have `-webkit-font-smoothing: antialiased` applied for better legibility
* Fonts should have `text-rendering: optimizeLegibility` applied for better legibility
* Fonts should be subset based on the content, alphabet or relevant language(s)
* Font weight should not change on hover or selected state to prevent layout shift
* Font weights below 400 should not be used
* Medium sized headings generally look best with a font weight between 500-600
* Adjust values fluidly by using CSS `clamp()`, e.g. `clamp(48px, 5vw, 72px)` for the `font-size` of a heading
* Where available, tabular figures should be applied with `font-variant-numeric: tabular-nums`, particularly in tables or when layout shifts are undesirable, like in timers
* Prevent text resizing unexpectedly in landscape mode on iOS with `-webkit-text-size-adjust: 100%`

## Motion

* Switching themes should not trigger transitions and animations on elements
  - Disable transitions temporarily when theme changes
  - For Next.js, use next-themes which prevents transitions out of the box
* Animation duration should not be more than 200ms for interactions to feel immediate
* Animation values should be proportional to the trigger size:
  - Don't animate dialog scale in from 0 → 1, fade opacity and scale from ~0.8
  - Don't scale buttons on press from 1 → 0.8, but ~0.96, ~0.9, or so
* Actions that are frequent and low in novelty should avoid extraneous animations:
  - Opening a right click menu
  - Deleting or adding items from a list
  - Hovering trivial buttons
  - This is taste-dependent but some interactions feel better with no motion (e.g., macOS right click menu only animates out, not in)
* Looping animations should pause when not visible on the screen to offload CPU and GPU usage
* Use `scroll-behavior: smooth` for navigating to in-page anchors, with an appropriate offset

## Touch

* Hover states should not be visible on touch press, use `@media (hover: hover)`
  - Most touch devices will temporarily flash the hover state on press unless explicitly defined for pointer devices only
* Font size for inputs should not be smaller than 16px to prevent iOS zooming on focus
* Inputs should not auto focus on touch devices as it will open the keyboard and cover the screen
* Apply `muted` and `playsinline` to `<video />` tags to auto play on iOS
* Disable `touch-action` for custom components that implement pan and zoom gestures to prevent interference from native behavior like zooming and scrolling
* Disable the default iOS tap highlight with `-webkit-tap-highlight-color: rgba(0,0,0,0)`, but always replace it with an appropriate alternative

## Optimizations

* Large `blur()` values for `filter` and `backdrop-filter` may be slow
* Scaling and blurring filled rectangles will cause banding, use radial gradients instead
* Sparingly enable GPU rendering with `transform: translateZ(0)` for unperformant animations
* Toggle `will-change` on unperformant scroll animations for the duration of the animation
  - Use `will-change` as a last resort to improve performance
  - Pre-emptively throwing it on elements for better performance may have the opposite effect
* Auto-playing too many videos on iOS will choke the device, pause or even unmount off-screen videos
* Bypass React's render lifecycle with refs for real-time values that can commit to the DOM directly
  - Sometimes beneficial to manipulate the DOM directly
  - Example: Instead of re-rendering on every wheel event, track delta in a ref and update elements directly in the callback
* Detect and adapt to the hardware and network capabilities of the user's device

## Accessibility

* Disabled buttons should not have tooltips, they are not accessible
  - Disabled buttons do not appear in tab order so the tooltip will never be announced for keyboard users
* Box shadow should be used for focus rings, not outline which won't respect radius
  - As of Safari 16.4, `outline` follows border radius, but not everyone updates immediately
* Focusable elements in a sequential list should be navigable with `↑` `↓`
* Focusable elements in a sequential list should be deletable with `⌘` `Backspace`
* To open immediately on press, dropdown menus should trigger on `mousedown`, not `click`
* Use a svg favicon with a style tag that adheres to the system theme based on `prefers-color-scheme`
* Icon only interactive elements should define an explicit `aria-label`
* Tooltips triggered by hover should not contain interactive content
* Images should always be rendered with `<img>` for screen readers and ease of copying from the right click menu
* Illustrations built with HTML should have an explicit `aria-label` instead of announcing the raw DOM tree to people using screen readers
* Gradient text should unset the gradient on `::selection` state
* When using nested menus, use a "prediction cone" to prevent the pointer from accidentally closing the menu when moving across other elements

## Design

* Optimistically update data locally and roll back on server error with feedback
* Authentication redirects should happen on the server before the client loads to avoid janky URL changes
* Style the document selection state with `::selection`
* Display feedback relative to its trigger:
  - Show a temporary inline checkmark on a successful copy, not a notification
  - Highlight the relevant input(s) on form error(s)
* Empty states should prompt to create a new item, with optional templates
