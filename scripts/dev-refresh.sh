#!/usr/bin/env bash
# Push your local edits to the coach plugin into every project where you've
# installed it from this folder (claude plugin install ... --scope local).
#
# Why this exists: Claude Code installs a *copy* of the plugin, cached by
# version. `claude plugin update` skips the refresh while the version number
# is unchanged, so during development we uninstall and reinstall instead.
# That copies the current working tree, uncommitted edits included.
#
# Usage:  scripts/dev-refresh.sh
# Then start a new Claude Code session in the project to pick up the changes.

set -euo pipefail

PLUGIN="coach@build-coach"
MARKETPLACE="build-coach"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INSTALLED="$HOME/.claude/plugins/installed_plugins.json"

echo "Validating plugin…"
claude plugin validate "$REPO_ROOT/plugins/coach" >/dev/null
echo "  ok"

if [[ ! -f "$INSTALLED" ]]; then
  echo "No installed plugins found ($INSTALLED is missing)." >&2
  exit 1
fi

# Projects where the coach is installed at local scope.
projects=()
while IFS= read -r line; do
  [[ -n "$line" ]] && projects+=("$line")
done < <(python3 -I -c '
import json, sys
data = json.load(open(sys.argv[1]))
for entry in data.get("plugins", {}).get(sys.argv[2], []):
    if entry.get("scope") == "local" and entry.get("projectPath"):
        print(entry["projectPath"])
' "$INSTALLED" "$PLUGIN")

if [[ ${#projects[@]} -eq 0 ]]; then
  echo "The coach isn't installed in any project yet. In a project folder, run:" >&2
  echo "  claude plugin install $PLUGIN --scope local" >&2
  exit 1
fi

echo "Refreshing marketplace…"
claude plugin marketplace update "$MARKETPLACE" >/dev/null
echo "  ok"

for dir in "${projects[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "Skipping $dir (folder no longer exists)"
    continue
  fi
  echo "Reinstalling in $dir"
  (
    cd "$dir"
    claude plugin uninstall "$PLUGIN" --scope local --keep-data >/dev/null
    claude plugin install "$PLUGIN" --scope local >/dev/null
  )
done

echo
echo "Done. Start a new Claude Code session in those projects to load the changes."
