#!/bin/bash

hyprctl dispatch togglefloating
hyprctl dispatch centerwindow

WINDOW_INFO=$(hyprctl activewindow -j)

X=$(echo "$WINDOW_INFO" | jq -r '.at[0]')
Y=$(echo "$WINDOW_INFO" | jq -r '.at[1]')
WIDTH=$(echo "$WINDOW_INFO" | jq -r '.size[0]')
HEIGHT=$(echo "$WINDOW_INFO" | jq -r '.size[1]')

CENTER_X=$((X + WIDTH / 2))
CENTER_Y=$((Y + HEIGHT / 2))

hyprctl dispatch movecursor "$CENTER_X" "$CENTER_Y"
