#!/bin/sh

# Get memory usage percentage
MEMORY_PRESSURE=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | cut -d% -f1)

if [ -z "$MEMORY_PRESSURE" ] || [ "$MEMORY_PRESSURE" = "100-" ]; then
  # Fallback method using vm_stat
  PAGES_FREE=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
  PAGES_ACTIVE=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  PAGES_INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
  PAGES_SPECULATIVE=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
  PAGES_WIRED=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
  
  TOTAL_PAGES=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE + PAGES_SPECULATIVE + PAGES_WIRED))
  USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED))
  
  if [ "$TOTAL_PAGES" -gt 0 ]; then
    MEMORY_PERCENTAGE=$(( (USED_PAGES * 100) / TOTAL_PAGES ))
  else
    MEMORY_PERCENTAGE=0
  fi
else
  MEMORY_PERCENTAGE=$(echo "$MEMORY_PRESSURE" | awk '{printf "%.0f", $1}')
fi

sketchybar --set "$NAME" icon="" label="${MEMORY_PERCENTAGE}%"
