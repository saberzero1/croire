#!/usr/bin/env bash
# Focus a named tab slot by label. If the tab was closed, recreate it with its app.
# Called with HERDR_PLUGIN_ACTION_ID set to "slot-1" through "slot-5".
set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"

declare -A SLOTS=(
  ["slot-1"]="scratch:"
  ["slot-2"]="editor:nvim"
  ["slot-3"]="watcher:"
  ["slot-4"]="agent:opencode"
  ["slot-5"]="git:lazygit"
)

ACTION="${HERDR_PLUGIN_ACTION_ID:-}"
SLOT="${SLOTS[$ACTION]:-}"

if [ -z "$SLOT" ]; then
  exit 1
fi

LABEL="${SLOT%%:*}"
COMMAND="${SLOT#*:}"

tab_id=$("$HERDR" tab list 2>/dev/null | jq -r ".result.tabs[] | select(.label == \"$LABEL\") | .tab_id" 2>/dev/null | head -1 || true)

if [ -n "$tab_id" ]; then
  "$HERDR" tab focus "$tab_id" >/dev/null 2>&1
else
  json=$("$HERDR" tab create --label "$LABEL" 2>/dev/null) || exit 0
  new_tab_id=$(echo "$json" | jq -r '.result.tab.tab_id // empty' 2>/dev/null || true)

  if [ -n "$COMMAND" ]; then
    pane_id=$(echo "$json" | jq -r '.result.root_pane.pane_id // empty' 2>/dev/null || true)
    if [ -n "$pane_id" ]; then
      sleep 0.2
      "$HERDR" pane send-text "$pane_id" "$COMMAND" >/dev/null 2>&1 || true
      "$HERDR" pane send-keys "$pane_id" enter >/dev/null 2>&1 || true
    fi
  fi

  if [ -n "$new_tab_id" ]; then
    "$HERDR" tab focus "$new_tab_id" >/dev/null 2>&1 || true
  fi
fi
