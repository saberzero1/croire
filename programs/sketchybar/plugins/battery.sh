#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Use simpler battery icons matching Waybar style
if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
elif [ "$PERCENTAGE" -ge 90 ]; then
  ICON="󱈑"
elif [ "$PERCENTAGE" -ge 60 ]; then
  ICON="󱊣"
elif [ "$PERCENTAGE" -ge 30 ]; then
  ICON="󱊢"
else
  ICON="��"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
