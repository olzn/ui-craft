# Design Philosophy

The shared design voice for the craft skills suite. Based on the work of [Benji Taylor](https://benji.org/family-values) and [Rauno Freiberg](https://rauno.me).

This file is not a skill. It is a reference document that domain skills point to when design intent matters.

---

## The Three Pillars

Apply in order. You cannot have Delight without Fluidity, and you cannot have Fluidity without Simplicity.

### 1. Simplicity: Gradual Revelation

Show only what matters right now.

- One primary action per view. If you can't point to it instantly, there are too many competing elements.
- Progressive disclosure over feature dumps. Let people pull information when they need it.
- Context-preserving overlays over full-page navigations. Don't teleport people.
- Stacked layers at visibly different heights. Depth communicates hierarchy.
- Every overlay has a title and a dismiss action. No mystery surfaces.

### 2. Fluidity: Seamless Transitions

Treat the interface as a physical space.

- No instant show/hide. Every appearance and disappearance animates. (See **motion-craft** for implementation.)
- Shared elements morph between states, never unmount and remount.
- Directional transitions match spatial logic. Forward moves right. Back moves left. (See **interaction-craft** for the reasoning.)
- Text changes use morphing, not instant replacement.
- Every animation is interruptible. No UI lockout during transitions.

### 3. Delight: Selective Emphasis

Delight is proportional to rarity.

- Daily actions need efficiency with subtle polish.
- Rare moments deserve theatrics.
- Polish every screen equally. Users notice the one you skipped.
- Celebrate completions with animation, not just a checkmark.
- Design empty states. They are the first thing a new user sees.
- Animate numbers and live data. Static numbers feel dead.

---

## Taste Principles

### What to avoid

Generic AI output has a recognisable aesthetic: Inter or system font with no pairing, purple-to-blue gradients, cards nested inside cards, low-contrast grey text on coloured backgrounds, and cookie-cutter component layouts. Every element of this list is a signal that no design thinking happened.

### What to aim for

- Typography is a deliberate choice, not a default. Display and body fonts are paired with intention. (See **type-craft**.)
- Colour is built from perceptual models, not HSL intuition. (See **colour-craft**.)
- Spacing is generous and rhythmic. Consistent vertical rhythm creates the visual order that makes a page feel composed.
- Layouts are tested at mobile (390px), tablet (768px), and desktop (1440px). Responsive design is not optional.
- Every interactive element has hover, active, and focus states. Nothing feels dead on interaction.

---

## How Domain Skills Use This Document

Each domain skill in the suite carries a short anchor connecting its domain to the relevant pillar. The full philosophy is available here for reference when the broader design intent matters.

- **motion-craft** implements the Fluidity pillar.
- **interaction-craft** decides when and whether Fluidity applies.
- **type-craft** builds the typographic foundation that Simplicity depends on.
- **colour-craft** builds the colour system that Delight expresses through.
- **detail-craft** catches the platform-level details that undermine all three pillars.
- **naming-craft** keeps the product and system vocabulary coherent across design, code, and copy.
- **token-craft** structures the foundation scales that all visual decisions draw from.
- **component-craft** structures individual components so all of the above remains consistent.
- **pattern-craft** assembles components into coherent features and pages.
