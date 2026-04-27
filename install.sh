#!/bin/sh
# Installs the UI Craft skill suite into a Codex, Claude Code, or project skills directory.

set -e

REPO_TARBALL="https://github.com/olzn/ui-craft/archive/refs/heads/main.tar.gz"
TARGET_DIR="${TARGET_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
SURFACE_SKILLS="surface-motion surface-interaction surface-typography surface-copy surface-colour surface-details"
SYSTEM_SKILLS="system-tokens system-naming system-components system-patterns"
SHARED_FILES="design-philosophy.md accessibility.md composition.md"
COORDINATOR_SKILL="ui-craft"
LEGACY_SKILLS="motion-craft interaction-craft type-craft copy-craft colour-craft detail-craft token-craft naming-craft component-craft pattern-craft surface-craft system-craft"

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd 2>/dev/null || echo "")"
TMP_DIR=""

cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}

trap cleanup EXIT INT TERM

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/surface" ] && [ -d "$SCRIPT_DIR/system" ]; then
  SRC_ROOT="$SCRIPT_DIR"
else
  TMP_DIR="${TMPDIR:-/tmp}/ui-craft-install-$$"
  mkdir -p "$TMP_DIR"
  curl -fsSL "$REPO_TARBALL" | tar -xz -C "$TMP_DIR"
  SRC_ROOT="$TMP_DIR/ui-craft-main"
fi

copy_file() {
  src="$1"
  dest="$2"
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  printf '  %s\n' "$dest"
}

copy_dir() {
  src="$1"
  dest="$2"
  rm -rf "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -R "$src" "$dest"
  printf '  %s/\n' "$dest"
}

echo "Installing UI Craft skills to $TARGET_DIR ..."
mkdir -p "$TARGET_DIR"

for skill in $LEGACY_SKILLS; do
  if [ -d "$TARGET_DIR/$skill" ]; then
    rm -rf "$TARGET_DIR/$skill"
    printf '  removed legacy %s/\n' "$TARGET_DIR/$skill"
  fi
done

for file in $SHARED_FILES; do
  copy_file "$SRC_ROOT/surface/$file" "$TARGET_DIR/$file"
done

copy_dir "$SRC_ROOT/$COORDINATOR_SKILL" "$TARGET_DIR/$COORDINATOR_SKILL"

for skill in $SURFACE_SKILLS; do
  copy_dir "$SRC_ROOT/surface/$skill" "$TARGET_DIR/$skill"
done

for skill in $SYSTEM_SKILLS; do
  copy_dir "$SRC_ROOT/system/$skill" "$TARGET_DIR/$skill"
done

echo "Done."
