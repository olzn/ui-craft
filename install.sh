#!/bin/sh
# Installs the UI Craft skill into your project's .claude/skills/ directory.
# Works both via curl pipe and from a local clone.

set -e

REPO_URL="https://raw.githubusercontent.com/olzn/ui-craft/main"
TARGET_DIR=".claude/skills"
SKILL="ui-craft.md"

# Detect if running from a local clone by checking for the skill file next to the script
SCRIPT_DIR="$(cd "$(dirname "$0" 2>/dev/null)" 2>/dev/null && pwd 2>/dev/null || echo "")"
LOCAL=false
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/$SKILL" ]; then
  LOCAL=true
fi

mkdir -p "$TARGET_DIR"

if [ "$LOCAL" = true ]; then
  cp "$SCRIPT_DIR/$SKILL" "$TARGET_DIR/$SKILL"
  echo "Installed $SKILL -> $TARGET_DIR/$SKILL"
else
  curl -fsSL "$REPO_URL/$SKILL" -o "$TARGET_DIR/$SKILL"
  echo "Downloaded $SKILL -> $TARGET_DIR/$SKILL"
fi

echo "Done. Skill installed to $TARGET_DIR/"
