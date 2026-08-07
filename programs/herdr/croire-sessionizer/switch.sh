#!/usr/bin/env bash
# Focus a named tab slot by label. If closed, recreate and reorder via tab.move.
# Called with HERDR_PLUGIN_ACTION_ID set to "slot-1" through "slot-5".
set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"
WS="${HERDR_WORKSPACE_ID:-}"

SLOT_LABELS=("scratch" "editor" "watcher" "agent" "git")
SLOT_COMMANDS=("" "nvim" "" "opencode" "lazygit")

ACTION="${HERDR_PLUGIN_ACTION_ID:-}"
SLOT_INDEX="${ACTION##slot-}"

if ! [[ "$SLOT_INDEX" =~ ^[1-5]$ ]]; then
  exit 1
fi

TARGET_LABEL="${SLOT_LABELS[$((SLOT_INDEX - 1))]}"
TARGET_CMD="${SLOT_COMMANDS[$((SLOT_INDEX - 1))]}"

ws_tabs() {
  "$HERDR" tab list ${WS:+--workspace "$WS"} 2>/dev/null
}

tab_id=$(ws_tabs | jq -r ".result.tabs[] | select(.label == \"$TARGET_LABEL\") | .tab_id" 2>/dev/null | head -1 || true)

if [ -n "$tab_id" ]; then
  "$HERDR" tab focus "$tab_id" >/dev/null 2>&1
  exit 0
fi

FOCUSED_CWD=$("$HERDR" pane current 2>/dev/null | jq -r '.result.pane.cwd // empty' 2>/dev/null || true)

json=$("$HERDR" tab create --label "$TARGET_LABEL" ${WS:+--workspace "$WS"} ${FOCUSED_CWD:+--cwd "$FOCUSED_CWD"} 2>/dev/null) || exit 0
new_tab_id=$(echo "$json" | jq -r '.result.tab.tab_id // empty' 2>/dev/null || true)

if [ -n "$TARGET_CMD" ]; then
  pane_id=$(echo "$json" | jq -r '.result.root_pane.pane_id // empty' 2>/dev/null || true)
  if [ -n "$pane_id" ]; then
    sleep 0.2
    "$HERDR" pane send-text "$pane_id" "$TARGET_CMD" >/dev/null 2>&1 || true
    "$HERDR" pane send-keys "$pane_id" enter >/dev/null 2>&1 || true
  fi
fi

if [ -n "$new_tab_id" ] && [ -n "${HERDR_SOCKET_PATH:-}" ]; then
  desired_pos=0
  for ((i = 0; i < SLOT_INDEX - 1; i++)); do
    prev_label="${SLOT_LABELS[$i]}"
    prev_pos=$(ws_tabs | jq -r \
      "[.result.tabs[].label] | index(\"$prev_label\") // null | if . != null then . + 1 else null end" \
      2>/dev/null || true)
    if [ -n "$prev_pos" ] && [ "$prev_pos" != "null" ]; then
      desired_pos="$prev_pos"
    fi
  done

  printf '%s\n' "$(jq -cn \
    --arg tab_id "$new_tab_id" \
    --argjson insert_index "$desired_pos" \
    '{id: "croire:tab:move", method: "tab.move", params: {tab_id: $tab_id, insert_index: $insert_index}}')" \
    | nc -N -U "$HERDR_SOCKET_PATH" >/dev/null 2>&1 || true
fi

if [ -n "$new_tab_id" ]; then
  "$HERDR" tab focus "$new_tab_id" >/dev/null 2>&1 || true
fi
