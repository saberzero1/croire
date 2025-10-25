#!/usr/bin/env bash

# Tokyo Night colors matching Waybar
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=0xffc0caf5  # Tokyo Night foreground
else
    sketchybar --set $NAME label.color=0x77c0caf5  # Tokyo Night foreground (transparent)
fi
