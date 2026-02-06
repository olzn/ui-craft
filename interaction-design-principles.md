---
name: interaction-design-principles
description: Apply when designing interaction patterns, evaluating why interfaces feel right or wrong, making decisions about gesture behaviour, animation timing, or spatial relationships. Use when questioning interaction choices, explaining design rationale, understanding motion principles, or debugging why an interaction feels off. Trigger when discussing concepts like interruptability, gesture thresholds, fidgetability, progressive disclosure through motion, kinetic physics, or frequency versus novelty trade-offs in animations.
---

# Interaction Design Principles

Conceptual principles for understanding why great interactions work. Based on [Rauno Freiberg's essay](https://rauno.me/craft/interaction-design).

## Related Skills

For implementation-specific guidelines (CSS properties, accessibility rules, performance optimizations), see the `web-interface-guidelines` skill.

## Overview

Interaction design is an artform to make experiences that fluidly respond to human intent. When does a swipe trigger an action? Do gestures retain momentum? What happens if a finger is covering content? How can we predict intent based on context? Executing well on details like these make products feel like a natural extension of ourselves.

It's not an artform in the same way as painting or composing music. There's a unique human component to interaction design. Ultimately people are trying to get stuff done using a product. Beauty in form and composition is not enough. There's an inherent satisfaction apparent in striking a holistic balance between form and function.

## Metaphors

Great interaction design rewards learning by reusing metaphors. You can use most touch interfaces with just two gestures: tapping and swiping.

### Conceptual Models

The sliding motion of swipe gestures tells users that the interface is composed of stacked layers, like a deck of cards. This knowledge compounds as users delve deeper into an ecosystem:

- Swiping up opens the interface (establishes the metaphor)
- Swiping down reveals system functionality (extends the metaphor)
- Horizontal swiping navigates between pages (mirrors physical book interaction from thousands of years)

### Interruptability

Great interactions are modelled after properties from the real world, like interruptability. Flipping a page in a book is interruptible—you can stop mid-gesture. The same should apply to digital gestures. Imagine if page transitions were non-interruptible animations you had to wait for.

### Physical Analogues

Pinching is intuitively associated with zooming because it mirrors movements requiring intricate motor skills—like picking up tiny objects or working with spices. The gesture naturally maps to precision adjustment.

**Anchor point precision:** On touch screens, the interface establishes an anchor point for zooming. It's easier and more precise to pick the anchor point with fingers pinched together (close proximity) than fingers apart. This implies:

- Fingers close together → zooming in (deliberate precision, like grabbing an object)
- Fingers starting apart → zooming out (less precision required for the anchor point)

## Kinetic Physics

Gestures should retain the momentum and angle at which they were thrown. They're never perfectly centred or consistent in timing. This builds on our natural sense of physics from the real world, like how swiping a playing card would feel.

**Example:** When dismissing an app, notice how the gesture retains momentum. The movement exhibits bounce characteristics based on the conceptual weight of the element being moved.

## Swipe Gesture Thresholds

When does a swipe trigger an action? It depends on the action's weight and destructiveness.

### Trigger During Gesture

Lightweight actions should trigger during the swipe after an arbitrary distance:

- **Displaying overlays** - Users can immediately see the surface, understand it's a search input, and dismiss if unwanted
- **Revealing layers** - Elements snap to position when they reach their logical, final position during the gesture
- **Peeking at content** - Allows quick scanning without commitment

Waiting for gesture end would feel broken and provide less affordance for these lightweight actions.

### Trigger on Gesture End

Destructive or significant actions require explicit intent through gesture completion:

- **Dismissing apps** - Could lose important progress; needs deliberate confirmation
- **Committing to navigation** - Prevents accidental commits when changing direction mid-gesture
- **Any action with consequences** - User might change their mind halfway through

**Threshold principle:** Despite swiping an adequate distance, the action doesn't trigger until gesture end. This makes it lightweight to briefly peek without committing, and quickly interrupt by changing direction.

## Responsive Gestures

Truly fluid gestures are immediately responsive, even before reaching the trigger threshold.

### Naive Implementation (Poor)

Exponentially animating from 0 → 1 after reaching a threshold:
- Zero affordance at low velocity
- No confidence that the element is interactive
- Not satisfying to perform

### Responsive Implementation (Good)

Apply the scale delta immediately, then animate past the threshold:
- Users feel the interaction responding
- Builds confidence in the interaction
- Satisfying to perform even at low velocity

**Example:** When pinching a card, the scale should change with finger movement immediately, not wait for a threshold before any visual feedback occurs.

### Interruption Handling

Poor: Swiping back immediately after a mistap requires waiting for the animation to complete.

Good: Gestures can be interrupted mid-animation—swiping back immediately cancels the forward motion.

## Spatial Consistency

Motion should communicate spatial relationships and origins.

### Origin Indication

**Dynamic Island example:**
- Tapping when collapsed → app slides out from under the Island (clear spatial origin)
- Tapping when expanded → app launches from icon (if visible) or slides in from right (indicates location in App Switcher)

**Why different behaviours?**
- Collapsed Island is unique to one app → clear origin point
- Expanded Island with multiple potential sources → needs disambiguation through launch location
- Sliding from right → communicates "first on the stack" in App Switcher

### Spatial Communication

Motion tells users where things are:
- Sliding in from right → "this is in the App Switcher, and now first in the stack"
- Launching from icon → establishes relationship between audio player and source app
- Morphing from one shape to another → shows transformation, not replacement

## Fluid Morphing

Seamless shape transitions require careful attention to detail.

### Icon Stretching Technique

When morphing an app to its icon:
- The icon's bottom ~10pt is intentionally duplicated and stretched
- Creates fluid vertical rectangle → square transition
- Fills the frame smoothly during the morph

**Assumption:** This technique assumes app icons adhere to platform guidelines (safe zones). Icons that violate guidelines (like using full-bleed images) can produce odd stretching effects.

## Frequency and Novelty

Animation decisions should consider how often an interaction occurs and its novelty.

### High Frequency, Low Novelty → No Animation

Actions performed hundreds of times daily with diminished novelty should avoid extraneous animations:

- Command menus (used constantly, mechanical input via keyboard)
- Context menus (macOS right-click: appears instantly, but fades out with selected item feedback)
- Core keyboard interactions (App Switcher on macOS: no animation for overlay)
- List item additions/deletions (when frequent)

**Rationale:**
- Inherent disconnect between peripheral device input and screen reduces visceral quality
- High frequency makes animations feel like cognitive burden after repetition
- Low novelty means no special flourish deserved

### Low Frequency, High Novelty → Animate

Actions that are infrequent or novel benefit from animation:
- First-time experiences
- Significant state changes
- Spatial relationship establishment
- Feedback for important actions

### Exception: Feedback Animations

Even high-frequency actions may have brief feedback animations:
- macOS context menu: selected item blinks accent colour before menu fades out
- Provides assurance that selection was registered
- Fade-out makes dismissal feel graceful rather than abrupt

### Perceived Performance

**Personal experience pattern:** After days of use, even snappy animations on core interactions can feel sluggish. Removing motion from keyboard-heavy workflows often dramatically improves perceived speed.

**Testing approach:** If interactions feel slow despite fast animation times, try removing motion entirely from high-frequency interactions.

## Fidgetability

Wonderful interactions don't have to be entirely practical. Repetitive movements that help release situational stress or enhance concentration can be intentionally designed.

### Intentional Fidget Design

Products designed to be satisfying to fidget with:

- **AirPods case** - Uncannily satisfying to open and close; too satisfying to be coincidental
- **Apple Pencil** - Tip unscrews for replacement, but provides satisfying friction for casual fidgeting while thinking
- **Physical objects** - Consider tactile feedback, resistance, and repetitive motion satisfaction

### Design Consideration

While there's no scientific research supporting fidgeting's benefits, it feels like part of intentional interaction design. Consider:
- Tactile feedback quality
- Resistance levels during interaction
- Satisfaction of repetitive motion
- Non-destructive, low-consequence interactions

## Applying These Principles

When designing or evaluating interactions, ask:

1. **Metaphor**: Does this build on existing mental models or physical world behaviours?
2. **Interruptability**: Can users change their mind mid-gesture?
3. **Physics**: Does motion feel natural and retain appropriate momentum?
4. **Threshold**: Should this trigger during or after the gesture completes?
5. **Responsiveness**: Does the interface respond immediately, even before the threshold?
6. **Spatial consistency**: Does motion communicate where things come from and go to?
7. **Frequency**: How often will users perform this action?
8. **Novelty**: Is this special enough to deserve animation?
9. **Fidgetability**: Could this be satisfying to repeat?

Remember: Great revelations surface from making something—filling your headspace with a problem—and then going for a synthesising daydreaming walk to stir the pot.
