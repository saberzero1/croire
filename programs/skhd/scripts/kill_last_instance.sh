#!/usr/bin/env bash

window_pid=$(yabai -m query --windows --window | jq -r '.id')
count_pid=$(yabai -m query --windows | jq "[.[] | select(.pid == ${window_pid})] | length")

if [ "$count_pid" -eq 1 ]; then
  yabai -m window --close
else
  kill "${window_pid}"
fi
