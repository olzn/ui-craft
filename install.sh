#!/bin/sh
# Installs the UI Craft skill suite into a Codex, Claude Code, or project skills directory.

set -e

REPO_TARBALL="https://github.com/olzn/ui-craft/archive/refs/heads/main.tar.gz"
TARGET_DIR="${TARGET_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
SURFACE_SKILLS="motion-craft interaction-craft type-craft colour-craft detail-craft"
SYSTEM_SKILLS="token-craft naming-craft component-craft pattern-craft"
SHARED_FILES="design-philosophy.md accessibility.md composition.md"

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd 2>/dev/null || echo "")"
TMP_DIR=""

cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}

trap cleanup EXIT INT TERM

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/surface-craft" ] && [ -d "$SCRIPT_DIR/system-craft" ]; then
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

for file in $SHARED_FILES; do
  copy_file "$SRC_ROOT/surface-craft/$file" "$TARGET_DIR/$file"
done

for skill in $SURFACE_SKILLS; do
  copy_dir "$SRC_ROOT/surface-craft/$skill" "$TARGET_DIR/$skill"
done

for skill in $SYSTEM_SKILLS; do
  copy_dir "$SRC_ROOT/system-craft/$skill" "$TARGET_DIR/$skill"
done

echo "Done."
