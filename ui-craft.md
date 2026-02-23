---
name: ui-craft
description: Apply the "Family Values" design philosophy to every UI you build. Use this skill whenever creating frontends, components, apps, landing pages, dashboards, or any user-facing interface. Enforces three core principles — Simplicity (gradual revelation), Fluidity (seamless transitions), and Delight (selective emphasis) — plus a concrete implementation checklist (CSS details, accessibility, touch, performance) drawn from Rauno Freiberg's interface guidelines. Prevents generic, static, lifeless UI.
---

# UI Craft

This skill encodes the design philosophy behind [Family](https://family.co), originally documented by Benji Taylor at [benji.org/family-values](https://benji.org/family-values), combined with Rauno Freiberg's interface implementation guidelines.

**Apply this before writing any UI code.**

---

## The Three Pillars

Apply in order. You cannot have Delight without Fluidity, and you cannot have Fluidity without Simplicity.

---

### 1. Simplicity — Gradual Revelation

Show only what matters right now. The interface should unfold progressively, not dump everything at once.

**Rules**:

- **One primary action per view.** Two equally weighted CTAs is a failure. Make everything else secondary.
- **Progressive disclosure over feature dumps.** Use layered trays, step-by-step flows, expandable sections. Never render a 12-field form when 3 steps of 4 fields works.
- **Context-preserving overlays over full-page navigations.** Sheets/trays/modals that overlay the current context keep users oriented. Full-screen transitions displace them.
- **Vary heights of stacked layers.** Each subsequent sheet/tray must be a visibly different height so the progression is clear. Never stack two identical-height layers.
- **Every sheet/tray/modal needs a title and dismiss action.**
- **Trays adapt to context.** A tray within a dark-themed flow adopts a darker color scheme.
- **Trays can launch full-screen flows.** A compact tray is a valid entry point for a multi-step full-screen experience.
- **Trays for transient actions; full screens for persistent destinations.** Confirmations, warnings, contextual info = tray. Settings, core content = full screen.

```jsx
// Progressive tray — compact, focused, context-aware
<Sheet>
  <SheetTrigger>Confirm Send</SheetTrigger>
  <SheetContent className="h-[45vh]"> {/* height varies from parent */}
    <SheetHeader>
      <SheetTitle>Review Transaction</SheetTitle>
      <DismissButton />
    </SheetHeader>
    <Button>Send $42.00</Button>
  </SheetContent>
</Sheet>
```

**Verify**: Every view has exactly one visually dominant action. No view presents more than 5–7 interactive elements without progressive disclosure.

---

### 2. Fluidity — Seamless Transitions

Treat the app as a physical space. Every element moves *from* somewhere *to* somewhere. No teleportation.

**Rules**:

- **No instant show/hide.** Every element that appears or disappears must animate. Use the transition that makes spatial sense — fade, slide, scale, or morph.
- **Shared element transitions.** If an element exists in both State A and State B (a card that expands, a button that becomes a sheet), morph it between them. Never unmount and remount.
- **Directional consistency.** Navigate forward → content enters from right. Go back → content enters from left. Tabs left of current slide left, tabs right slide right.
- **Text morphing over instant replacement.** When labels change (e.g., "Continue" → "Confirm"), animate the transition. Use [torph](https://torph.lochie.me/) (`npm i torph`) — dependency-free, works with React/Vue/Svelte. It identifies shared letter sequences and keeps them fixed while the rest morphs. Crossfade is the minimum fallback.
- **Only animate what changes.** If a sentence gains or loses a word, keep the unchanged portion static.
- **Persistent elements stay put.** If a header or component persists across a transition, it must NOT animate out and back in. Only the changing parts move.
- **Loading states travel to their destination.** A spinner moves to where the user will look for results (e.g., after submitting a transaction, the spinner migrates to the activity tab icon).
- **Micro-directional cues.** Chevrons, arrows, and carets animate to reflect the action. A `→` becomes `←` on back-navigation. Accordion chevrons rotate on expand.
- **Unified interpolation.** All visual elements driven by the same data share the same easing. The line, the label, the axis, and the badge all move as one.

```jsx
// Text morphing — use torph
import { TextMorph } from 'torph/react';
<TextMorph>{label}</TextMorph>

// Directional tab transitions
const direction = newIndex > currentIndex ? 1 : -1;
<motion.div
  key={currentTab}
  initial={{ x: direction * 20, opacity: 0 }}
  animate={{ x: 0, opacity: 1 }}
  exit={{ x: -direction * 20, opacity: 0 }}
  transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}
/>

// Shared element: card → detail view
<motion.div
  layoutId={`card-${id}`}
  className={isExpanded ? "fixed inset-0 rounded-none" : "rounded-xl"}
  transition={{ duration: 0.4, ease: [0.16, 1, 0.3, 1] }}
/>
```

**Default easing**: `cubic-bezier(0.16, 1, 0.3, 1)` — fast start, gentle settle. Use for all entrances and morphs. Use `cubic-bezier(0.4, 0, 1, 1)` for exits only. Never use linear.

**Verify**: No element appears or disappears without a transition. No shared element is unmounted and remounted across states.

---

### 3. Delight — Selective Emphasis

Delight is proportional to rarity. The less frequently a feature is used, the more expressive it should be. Daily actions need efficiency with subtle polish. Rare moments deserve theatrics.

**Rules**:

- **Polish every screen equally.** The settings page, the empty state, the error screen — all receive the same care as the hero. One unpolished corner makes the whole feel unpolished.
- **Celebrate completions.** Significant actions (backup complete, onboarding done, first transaction) get confetti, a custom animation, or a sound — not just a green checkmark.
- **Make destructive actions satisfying.** Deleted items tumble or shrink away with visual feedback. Destructive ≠ unpleasant.
- **Animate numbers and live data.** Values that change (prices, counts, balances) should count/flip/morph. Use [number-flow](https://number-flow.barvian.me) (`npm i @number-flow/react`) — dependency-free, accessible, handles formatting and locale via `Intl.NumberFormat`. For real-time line charts, use [liveline](https://benji.org/liveline) (`npm i liveline`) — one canvas, 60fps interpolation, no dependencies beyond React 18.
- **Design empty states.** Use an animated arrow pointing toward the create action, a floating illustration, and a warm message. Never just render "No items yet."
- **Easter eggs reward exploration.** Hide moments in low-frequency features where discovery feels like reward.
- **Drag-and-drop should feel satisfying.** Stacking animations, smooth reorder, visual feedback on lift.

**Delight calibration reference**:

| Feature | Frequency | Delight Level | Implementation |
|---|---|---|---|
| Number input | Daily | Subtle | Commas shift position as digits are typed |
| Tab/chart navigation | Daily | Subtle | Arrow icon flips direction with value change |
| Empty state | First visit | Medium | Animated arrow + floating illustration |
| Item reorder | Occasional | Medium | Stacking animation + smooth drop |
| Delete/trash | Occasional | Medium | Item shrinks/tumbles away + haptic/sound |
| First feature use | Once | High | Animated guide arrow in empty state |
| Critical completion | Once | Theatrical | Confetti explosion + celebratory sound |
| Easter egg | Rare | Theatrical | Hidden gesture triggers unique animation |

```jsx
// Animated number — use number-flow
import NumberFlow from '@number-flow/react';
<NumberFlow value={totalPrice} format={{ style: 'currency', currency: 'USD' }} />

// Real-time chart — liveline handles interpolation, momentum arrows, scrub, theming
import { Liveline } from 'liveline';
<div style={{ height: 200 }}>
  <Liveline
    data={history}           // [{ time, value }]
    value={latestValue}      // current number
    momentum                 // directional arrows (green/red/grey)
    showValue                // 60fps DOM overlay, no re-renders
    color="#3b82f6"          // derives full palette from one color
  />
</div>

// Designed empty state
function EmptyState() {
  return (
    <div className="flex flex-col items-center gap-4 py-16">
      <motion.div animate={{ y: [0, -8, 0] }} transition={{ repeat: Infinity, duration: 2, ease: "easeInOut" }}>
        <IllustrationIcon />
      </motion.div>
      <p className="text-muted">Nothing here yet</p>
      <motion.div animate={{ x: [0, 5, 0] }} transition={{ repeat: Infinity, duration: 1.5 }}>
        <ArrowRight className="inline mr-1" /> Create your first item
      </motion.div>
    </div>
  );
}

// Confetti on significant completion
function CompletionScreen() {
  useEffect(() => { playSound('success'); }, []);
  return (
    <motion.div initial={{ scale: 0.8, opacity: 0 }} animate={{ scale: 1, opacity: 1 }}
      transition={{ type: "spring", damping: 15, stiffness: 200 }}>
      <ConfettiExplosion />
      <h2>You're all set!</h2>
    </motion.div>
  );
}
```

**Verify**: Every empty state has a designed layout. Completion flows have more than a static success message. No two screens have visibly different levels of polish.

---

## Pre-Delivery Checklist

Run through every item before considering any UI complete.

### Simplicity
- Each screen has exactly one visually dominant action
- Complex flows are broken into sequential steps
- Information is revealed progressively, not all at once
- Context is preserved during transitions (overlays over navigations)
- Stacked layers are visibly different heights
- Every overlay has a title and dismiss action
- User always knows where they are and how to go back

### Fluidity
- Zero instant show/hide — every appearance/disappearance animates
- Shared elements morph between states (never unmount/remount)
- Directional transitions match spatial logic (forward = right, back = left)
- Persistent elements do not redundantly animate during transitions
- Text changes use torph or crossfade at minimum
- Only the changing portion of partial text updates animates
- Loading indicators move to where results will appear
- Chevrons and arrows animate to reflect direction
- Elements driven by the same data share the same easing
- Default easing is `cubic-bezier(0.16, 1, 0.3, 1)`

### Delight
- Frequent features have subtle micro-interactions
- Infrequent features have memorable moments
- Empty states have designed layouts with illustrations and prompts
- Completions are celebrated with animation, not just a checkmark
- Numeric values animate when they change
- All screens are equally polished

### General Taste
- No generic AI aesthetics (Inter as the only font, purple/blue gradients, cookie-cutter card layouts)
- Typography is intentional — display + body font pairing
- Color palette has a dominant color with sharp accents
- Spacing is generous and consistent
- Interface feels like a physical space, not a slideshow

---

## Anti-Patterns

Never do these:

1. **Static tab switches.** Always slide directionally.
2. **Modals that pop from nowhere.** Grow from trigger or slide from edge. Never `opacity: 0 → 1` centered.
3. **Skeleton screens that don't match the real layout.** The skeleton must match the actual content structure.
4. **Redundant animations.** A persistent header must not animate out and back in during a page transition.
5. **Linear easing.** Never use `linear` for UI transitions.
6. **Plain "No items" text.** Every empty state must be designed.
7. **Uniform sizing in stacked layers.** Each layer must be a different height.
8. **Toasts for important outcomes.** Toasts are for background info only. Success/error/completion feedback must be inline, contextual, and animated.
9. **Forms as stacked inputs.** Use step-by-step flows with transitions.
10. **Buttons without interaction states.** Always implement hover, active, and focus states.
11. **Animating unchanged text.** If only one word changes, only that word moves.
12. **Spinners stuck at origin.** Move loading indicators to where the result will appear.

---

## Easing & Timing Reference

| Use Case | Easing | Duration |
|---|---|---|
| Element entering | `cubic-bezier(0.16, 1, 0.3, 1)` | 300–400ms |
| Element exiting | `cubic-bezier(0.4, 0, 1, 1)` | 200–250ms |
| Shared element morph | `cubic-bezier(0.16, 1, 0.3, 1)` | 350–500ms |
| Micro-interaction (hover, press) | `cubic-bezier(0.2, 0, 0, 1)` | 100–150ms |
| Spring (bouncy) | `damping: 20, stiffness: 300` | auto |
| Spring (smooth) | `damping: 30, stiffness: 200` | auto |
| Number counting | ease-out cubic | 400–800ms |
| Page transition | `cubic-bezier(0.16, 1, 0.3, 1)` | 300ms |
| Stagger between items | — | 30–60ms per item |

---

## Recommended Libraries

Use these before rolling your own. They are built by the same people behind Family and embody this philosophy:

| Library | Purpose | Install |
|---|---|---|
| [number-flow](https://number-flow.barvian.me) | Animated number transitions. Dependency-free, accessible, handles formatting and locale via `Intl.NumberFormat`. React, Vue, Svelte. | `npm i @number-flow/react` |
| [torph](https://torph.lochie.me/) | Dependency-free text morphing. Handles shared-letter transitions automatically. React, Vue, Svelte. | `npm i torph` |
| [liveline](https://benji.org/liveline) | Real-time animated line charts. One canvas, 60fps lerp, momentum arrows, no dependencies beyond React 18. | `npm i liveline` |

---

## Implementation Checklist (Rauno Freiberg)

Concrete CSS, accessibility, and interaction details. Apply these to every UI.

### Interactivity
- Clicking an input label focuses the input
- Inputs are wrapped in `<form>` so Enter submits
- Inputs use the appropriate `type` (`password`, `email`, etc.)
- `spellcheck` and `autocomplete` are disabled on most inputs
- `required` attribute is used for HTML form validation
- Icon/prefix decorations are absolutely positioned with padding, not placed beside the input
- Toggles take effect immediately — no confirmation step
- Buttons are disabled after submission to prevent duplicate requests
- Interactive elements have `user-select: none` on inner content
- Decorative elements (glows, gradients) have `pointer-events: none`
- List items have no dead zones — use padding between elements, not gaps

### Typography
- `-webkit-font-smoothing: antialiased` on all text
- `text-rendering: optimizeLegibility` on all text
- Fonts are subsetted to the content's alphabet/language
- Font weight never changes on hover (causes layout shift)
- No font weights below 400
- Mid-size headings use weight 500–600
- Headings use fluid sizing: `clamp(48px, 5vw, 72px)`
- Numbers in tables/timers use `font-variant-numeric: tabular-nums`
- `-webkit-text-size-adjust: 100%` is set to prevent iOS landscape resizing

### Motion
- Theme switches disable transitions temporarily (use `next-themes` in Next.js)
- Interaction animations are max 200ms
- Scale is proportional to trigger size: dialogs from ~0.8 not 0; buttons press to ~0.96 not 0.8
- High-frequency / low-novelty actions skip animation (right-click menus, list add/delete)
- Looping animations pause when off-screen (`IntersectionObserver`)
- In-page anchor scrolling uses `scroll-behavior: smooth` with offset

### Touch
- Hover states are wrapped in `@media (hover: hover)` — no flash on tap
- Input font size is minimum 16px (prevents iOS zoom on focus)
- Inputs are not autofocused on touch devices (keyboard covers screen)
- `<video>` elements always have `muted` and `playsinline` for iOS autoplay
- Custom pan/zoom disables `touch-action` to prevent native interference
- Default iOS tap highlight is replaced: `-webkit-tap-highlight-color: rgba(0,0,0,0)` + custom alternative

### Performance
- Large `blur()` values are used sparingly — they are slow
- Scaling + blurring filled rectangles uses radial gradients to avoid banding
- `transform: translateZ(0)` is used sparingly to push to GPU
- `will-change` is a last resort only — pre-emptive use can hurt performance
- Off-screen autoplaying videos on iOS are paused/unmounted
- Real-time values use refs + direct DOM manipulation, not React state on every scroll/wheel event

### Accessibility
- Disabled buttons have no tooltips (not in tab order, never announced)
- Focus rings use `box-shadow` not `outline` (respects border-radius)
- Sequential lists are navigable with `↑`/`↓`, deletable with `⌘ Backspace`
- Dropdown menus trigger on `mousedown` not `click` for instant open
- SVG favicons use `prefers-color-scheme` in a style tag
- Icon-only buttons have an explicit `aria-label`
- Hover tooltips contain no interactive content
- Images use `<img>` not CSS backgrounds (screen readers + right-click)
- HTML illustrations have an explicit `aria-label` on the wrapper
- Gradient text unsets the gradient on `::selection`
- Nested menus implement a "prediction cone" to prevent accidental close

### Design Details
- Updates are optimistic locally, rolled back with feedback on error
- Auth redirects happen server-side before the client loads (no URL flash)
- `::selection` is styled across the document
- Feedback is relative to the trigger: inline checkmark on copy (not a toast), highlight on input error
- Empty states prompt creation with optional templates
