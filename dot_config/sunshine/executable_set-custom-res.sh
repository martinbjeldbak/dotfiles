#!/bin/bash

source "$(dirname "$0")/lib.sh"
setup_hyprland

width=1920
height=1080
refresh_rate=${3:-60}

display=$(get_display)

# Save current mode before changing so undo can restore it exactly
current_mode=$(hyprctl monitors all | awk '/^Monitor/{found=1; next} found{print $1; exit}')
echo "Saving current mode: $current_mode"
echo "$current_mode" > "$SUNSHINE_MONITOR_CACHE"

echo "Setting ${display} to ${width}x${height}@${refresh_rate}"
hyprctl keyword monitor "${display},${width}x${height}@${refresh_rate},0x0,1,vrr,2"

echo "Stopping hypridle"
systemctl --user stop hypridle.service

echo "Switching to workspace 8"
hyprctl dispatch workspace 8
