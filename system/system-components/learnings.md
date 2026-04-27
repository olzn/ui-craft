# Learnings

## React 19 ref as regular prop
**Context:** Forwarding refs in React 19 projects.
**Finding:** React 19 makes `ref` a regular prop on function components. `forwardRef` is no longer needed; accept `ref` directly in the props object. However, mixed React 18/19 codebases (e.g. libraries supporting both) still need `forwardRef` for backwards compatibility.
**Resolution:** For React 19-only projects, accept `ref` in props directly. For libraries, continue using `forwardRef` until React 18 support is dropped.

## CVA `compoundVariants` override order
**Context:** Using CVA `compoundVariants` to apply styles when multiple variant values combine.
**Finding:** `compoundVariants` are applied in array order, and later entries override earlier ones. When two compound variants match the same prop combination, the last one wins. This is deterministic but not obvious from the types.
**Resolution:** Place more specific compound variants after more general ones in the array. Add a comment when override order matters.

## `tailwind-merge` last-wins resolution
**Context:** Merging consumer `className` with component base classes via `cn()`.
**Finding:** `tailwind-merge` resolves conflicts by keeping the last class. This means `cn(buttonVariants({ variant }), className)` lets the consumer override any variant style, which is the intended behaviour. But `cn(className, buttonVariants({ variant }))` would make the variant always win, preventing overrides.
**Resolution:** Always place `className` last in `cn()` calls so consumer overrides work correctly.
