#!/usr/bin/env bash

# Tokyo Night colors matching Waybar
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
      icon.color=0xff24283b \
      background.drawing=on
else
    sketchybar --set $NAME \
      icon.color=0xffc0caf5 \
      background.drawing=off
fi
