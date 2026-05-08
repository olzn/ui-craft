#!/bin/sh
# Dependency-free integrity checks for the UI Craft skill suite.

set -u

failures=0

fail() {
  failures=$((failures + 1))
  printf 'FAIL: %s\n' "$1" >&2
}

check_file() {
  if [ ! -f "$1" ]; then
    fail "missing file: $1"
  fi
}

check_dir() {
  if [ ! -d "$1" ]; then
    fail "missing directory: $1"
  fi
}

case "$(pwd)" in
  */ui-craft) ;;
  *)
    if [ ! -f "install.sh" ] || [ ! -d "surface" ] || [ ! -d "system" ]; then
      fail "run scripts/validate.sh from the repository root"
    fi
    ;;
esac

check_file "install.sh"

if ! sh -n install.sh; then
  fail "install.sh has shell syntax errors"
fi

if [ -n "$(find . -name .DS_Store -print)" ]; then
  fail ".DS_Store files are present"
fi

check_file "surface/design-philosophy.md"
check_file "surface/accessibility.md"
check_file "surface/composition.md"
check_file "surface/quality.md"

skill_files="$(find ui-craft surface system -name SKILL.md -print | sort)"

if [ -z "$skill_files" ]; then
  fail "no SKILL.md files found"
fi

for skill_file in $skill_files; do
  skill_dir="$(dirname "$skill_file")"
  skill_name="$(basename "$skill_dir")"

  check_file "$skill_file"
  check_file "$skill_dir/agents/openai.yaml"
  check_file "$skill_dir/learnings.md"

  first_line="$(sed -n '1p' "$skill_file")"
  if [ "$first_line" != "---" ]; then
    fail "$skill_file missing opening YAML frontmatter"
  fi

  if ! grep -q '^name: [a-z0-9][a-z0-9-]*$' "$skill_file"; then
    fail "$skill_file missing valid name frontmatter"
  fi

  if ! grep -q '^description: .' "$skill_file"; then
    fail "$skill_file missing description frontmatter"
  fi

  frontmatter_name="$(sed -n 's/^name: //p' "$skill_file" | head -n 1)"
  if [ "$frontmatter_name" != "$skill_name" ]; then
    fail "$skill_file name does not match folder: $frontmatter_name != $skill_name"
  fi

  refs="$(grep -Eo 'references/[A-Za-z0-9._/-]+\.md' "$skill_file" | sort -u || true)"
  for ref in $refs; do
    if [ ! -f "$skill_dir/$ref" ]; then
      fail "$skill_file references missing file: $ref"
    fi
  done

  if [ -d "$skill_dir/references" ]; then
    for shared in design-philosophy.md accessibility.md composition.md quality.md; do
      if [ -f "$skill_dir/references/$shared" ]; then
        if ! cmp -s "surface/$shared" "$skill_dir/references/$shared"; then
          fail "$skill_dir/references/$shared differs from surface/$shared"
        fi
      fi
    done
  fi
done

if [ "$failures" -eq 0 ]; then
  printf 'All UI Craft validation checks passed.\n'
  exit 0
fi

printf '%s validation check(s) failed.\n' "$failures" >&2
exit 1
