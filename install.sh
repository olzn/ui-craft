#!/bin/sh
# Installs Rauno Design Skills into your project's .claude/skills/ directory.
# Works both via curl pipe and from a local clone.

set -e

REPO_URL="https://raw.githubusercontent.com/olzn/rauno-design-skills/main"
TARGET_DIR=".claude/skills"
SKILLS="interaction-design-principles.md web-interface-guidelines.md"

# Detect if running from a local clone by checking for a skill file next to the script
SCRIPT_DIR="$(cd "$(dirname "$0" 2>/dev/null)" 2>/dev/null && pwd 2>/dev/null || echo "")"
LOCAL=false
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/interaction-design-principles.md" ]; then
  LOCAL=true
fi

mkdir -p "$TARGET_DIR"

for skill in $SKILLS; do
  if [ "$LOCAL" = true ]; then
    cp "$SCRIPT_DIR/$skill" "$TARGET_DIR/$skill"
    echo "Installed $skill -> $TARGET_DIR/$skill"
  else
    curl -fsSL "$REPO_URL/$skill" -o "$TARGET_DIR/$skill"
    echo "Downloaded $skill -> $TARGET_DIR/$skill"
  fi
done

echo "Done. Skills installed to $TARGET_DIR/"
