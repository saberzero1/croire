#!/usr/bin/env bash
# Croire Sessionizer — FZF project picker
# Scans project directories, shows FZF picker, creates/focuses workspace.
# Mirrors tmux-sessionizer behavior: scan roots at max depth, pick via FZF,
# create workspace with layout or focus existing.
set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"

# Project roots and max depth (same as tmux-sessionizer config)
ROOTS=(
  "$HOME/Repos"
  "$HOME/Documents/Repos"
  "$HOME/Work/Repos"
  "$HOME/Work/External/Repos"
)
MAX_DEPTH=3

# Collect project directories (git repos only, like tmux-sessionizer)
candidates=()
for root in "${ROOTS[@]}"; do
  if [ -d "$root" ]; then
    while IFS= read -r dir; do
      candidates+=("$dir")
    done < <(find "$root" -maxdepth "$MAX_DEPTH" -name ".git" -type d 2>/dev/null | sed 's|/\.git$||' | sort -u)
  fi
done

# Add zoxide top results (deduplicated against filesystem scan)
if command -v zoxide >/dev/null 2>&1; then
  while IFS= read -r dir; do
    if [ -d "$dir/.git" ]; then
      candidates+=("$dir")
    fi
  done < <(zoxide query --list 2>/dev/null | head -20)
fi

# Deduplicate
readarray -t candidates < <(printf '%s\n' "${candidates[@]}" | sort -u)

if [ ${#candidates[@]} -eq 0 ]; then
  echo "No projects found in configured roots." >&2
  exit 0
fi

# FZF picker
selected=$(SHELL=/bin/sh printf '%s\n' "${candidates[@]}" | FZF_DEFAULT_OPTS="" fzf \
  --prompt="Project > " \
  --header="Pick a project (or ESC to cancel)" \
  --preview="bash -c 'ls -la {}'" \
  --preview-window=right:40% \
  --reverse \
  --height=80% \
) || exit 0

if [ -z "$selected" ]; then
  exit 0
fi

# Workspace label = directory basename
label=$(basename "$selected")

# Check if workspace with this label already exists
existing=$("$HERDR" workspace list 2>/dev/null | jq -r ".result.workspaces[] | select(.label == \"$label\") | .workspace_id" 2>/dev/null || true)

if [ -n "$existing" ]; then
  # Focus existing workspace
  "$HERDR" workspace focus "$existing" >/dev/null 2>&1
else
  # Create new workspace — the layout.sh event hook will bootstrap tabs
  "$HERDR" workspace create --label "$label" --cwd "$selected" --focus >/dev/null 2>&1
fi
