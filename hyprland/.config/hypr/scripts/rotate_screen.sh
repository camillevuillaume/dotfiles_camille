#!/bin/bash
# File to store rotation toggle state (0 = off, 1 = on)
TOGGLE_FILE="$HOME/.config/hypr/rotation-toggle"

# Ensure toggle file exists, default to enabled (1)
[ -f "$TOGGLE_FILE" ] || echo "1" > "$TOGGLE_FILE"

# Run program to rotate screen based on orientation
if [ "$(cat "$TOGGLE_FILE")" -eq 1 ]; then
    pkill -f iio-hyprland
    iio-hyprland &
else
    pkill -f iio-hyprland
fi

# Monitor sensor and adjust screen based on orientation
#monitor-sensor | while read -r line; do
#    # Check if rotation is enabled
#    if [ "$(cat "$TOGGLE_FILE")" -eq 1 ]; then
#        if [[ $line == *"orientation changed: normal"* ]]; then
#            hyprctl keyword monitor "eDP-1,transform,0"
#            hyprctl keyword input:touchdevice:transform 0
#        elif [[ $line == *"orientation changed: right-up"* ]]; then
#            hyprctl keyword monitor "eDP-1,transform,3"
#            hyprctl keyword input:touchdevice:transform 3
#        elif [[ $line == *"orientation changed: left-up"* ]]; then
#            hyprctl keyword monitor "eDP-1,transform,1"
#            hyprctl keyword input:touchdevice:transform 1
#        elif [[ $line == *"orientation changed: bottom-up"* ]]; then
#            hyprctl keyword monitor "eDP-1,transform,2"
#            hyprctl keyword input:touchdevice:transform 2
#        fi
#    fi
#done
