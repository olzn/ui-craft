#!/bin/sh
# Installs the UI Craft skill suite into your project's .claude/skills/ directory.
# Works both via curl pipe and from a local clone.

set -e

REPO_URL="https://raw.githubusercontent.com/olzn/ui-craft/main"
TARGET_DIR=".claude/skills"

# Shared reference files (not skills)
SHARED_FILES="design-philosophy.md accessibility.md composition.md"

# Skill folders
SKILLS="motion-craft interaction-craft type-craft colour-craft detail-craft"

# Detect if running from a local clone
SCRIPT_DIR="$(cd "$(dirname "$0" 2>/dev/null)" 2>/dev/null && pwd 2>/dev/null || echo "")"
LOCAL=false
if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/motion-craft" ]; then
  LOCAL=true
fi

install_file() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ "$LOCAL" = true ]; then
    cp "$SCRIPT_DIR/$src" "$dest"
  else
    curl -fsSL "$REPO_URL/$src" -o "$dest"
  fi
  echo "  $dest"
}

echo "Installing UI Craft skills to $TARGET_DIR/ ..."

for file in $SHARED_FILES; do
  install_file "$file" "$TARGET_DIR/$file"
done

for skill in $SKILLS; do
  install_file "$skill/SKILL.md" "$TARGET_DIR/$skill/SKILL.md"
  install_file "$skill/learnings.md" "$TARGET_DIR/$skill/learnings.md"
done

echo "Done."
