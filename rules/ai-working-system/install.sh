#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
DEST="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

mkdir -p "$DEST/skills"

if [ -f "$DEST/AGENTS.md" ] && ! cmp -s "$REPO_DIR/rules/ai-working-system/CORE.md" "$DEST/AGENTS.md"; then
  cp "$DEST/AGENTS.md" "$DEST/AGENTS.md.bak"
  echo "Sacuvan prethodni globalni AGENTS.md u $DEST/AGENTS.md.bak"
fi

cp "$REPO_DIR/rules/ai-working-system/CORE.md" "$DEST/AGENTS.md"

for skill_dir in "$REPO_DIR"/.opencode/skills/aiws-*; do
  name="$(basename "$skill_dir")"
  mkdir -p "$DEST/skills/$name"
  cp "$skill_dir/SKILL.md" "$DEST/skills/$name/SKILL.md"
done

echo "AI Working System instaliran u $DEST"
echo "Ponovo pokreni opencode da bi se pravila ucitala."
