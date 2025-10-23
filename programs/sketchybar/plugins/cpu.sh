#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENTAGE="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

if [ "$CPU_PERCENTAGE" = "" ]; then
  exit 0
fi

case "${CPU_PERCENTAGE}" in
  9[0-9]|100) ICON="󱚡"
  ;;
  [7-8][0-9]) ICON="󱚟"
  ;;
  [5-6][0-9]) ICON="󰚩"
  ;;
  [3-4][0-9]) ICON="󱚣"
  ;;
  [1-2][0-9]) ICON="󱜙"
  ;;
  *) ICON="󱚥"
esac

sketchybar --set $NAME icon="$ICON" label="$CPU_PERCENTAGE%"
