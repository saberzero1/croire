#!/bin/sh

# Get the current date in a format matching Waybar
DATE=$(date '+%A, %d %b')

sketchybar --set "$NAME" label="$DATE"
