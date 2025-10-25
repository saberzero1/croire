#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
# Use awk to properly filter by username to avoid false matches
CURRENT_USER=$(whoami)
CPU_SYS=$(echo "$CPU_INFO" | awk -v user="$CURRENT_USER" -v cores="$CORE_COUNT" '$2 != user {sum+=$1} END {print sum/(100.0 * cores)}')
CPU_USER=$(echo "$CPU_INFO" | awk -v user="$CURRENT_USER" -v cores="$CORE_COUNT" '$2 == user {sum+=$1} END {print sum/(100.0 * cores)}')

CPU_PERCENTAGE="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

if [ "$CPU_PERCENTAGE" = "" ]; then
  exit 0
fi

# Use a single CPU icon matching Waybar
ICON=""

sketchybar --set $NAME icon="$ICON" label="$CPU_PERCENTAGE%"
