#!/bin/sh
# Installs Rauno Design Skills into your project's .claude/skills/ directory.
# Run from your project root, or from within this repo.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR=".claude/skills"

SKILLS="interaction-design-principles.md web-interface-guidelines.md"

mkdir -p "$TARGET_DIR"

for skill in $SKILLS; do
  if [ -f "$SCRIPT_DIR/$skill" ]; then
    cp "$SCRIPT_DIR/$skill" "$TARGET_DIR/$skill"
    echo "Installed $skill -> $TARGET_DIR/$skill"
  else
    echo "Warning: $skill not found in $SCRIPT_DIR" >&2
  fi
done

echo "Done. Skills installed to $TARGET_DIR/"
