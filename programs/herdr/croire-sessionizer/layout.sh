#!/usr/bin/env bash
# Bootstrap workspace with 5 named tabs matching the tmux session template.
# Triggered by workspace.created event or invoked manually.
set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"
WORKSPACE="${HERDR_WORKSPACE_ID:-}"

if [ -z "$WORKSPACE" ]; then
  WORKSPACE=$("$HERDR" workspace list 2>/dev/null | jq -r '.result.workspaces[] | select(.focused == true) | .workspace_id' 2>/dev/null || true)
fi

if [ -z "$WORKSPACE" ]; then
  exit 0
fi

CWD="${CROIRE_CWD:-}"
if [ -z "$CWD" ]; then
  CWD=$(pwd)
fi

tabs=$("$HERDR" tab list --workspace "$WORKSPACE" 2>/dev/null | jq -r '.result.tabs | length' 2>/dev/null || echo "0")
if [ "$tabs" -gt 1 ]; then
  exit 0
fi

first_tab=$("$HERDR" tab list --workspace "$WORKSPACE" 2>/dev/null | jq -r '.result.tabs[0].tab_id // empty' 2>/dev/null || true)
if [ -n "$first_tab" ]; then
  "$HERDR" tab rename "$first_tab" "scratch" >/dev/null 2>&1 || true
fi

create_tab() {
  local label="$1" cmd="${2:-}"
  local json pane_id
  json=$("$HERDR" tab create --label "$label" --cwd "$CWD" --workspace "$WORKSPACE" 2>/dev/null) || return 0
  if [ -n "$cmd" ]; then
    pane_id=$(echo "$json" | jq -r '.result.root_pane.pane_id // empty' 2>/dev/null || true)
    if [ -n "$pane_id" ]; then
      sleep 0.2
      "$HERDR" pane send-text "$pane_id" "$cmd" >/dev/null 2>&1 || true
      "$HERDR" pane send-keys "$pane_id" enter >/dev/null 2>&1 || true
    fi
  fi
}

create_tab "editor"  "nvim"
create_tab "watcher"
create_tab "agent"   "opencode"
create_tab "git"     "lazygit"

if [ -n "$first_tab" ]; then
  "$HERDR" tab focus "$first_tab" >/dev/null 2>&1 || true
fi
