#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=0xffebdbb2
else
    sketchybar --set $NAME label.color=0x77ebdbb2
fi
