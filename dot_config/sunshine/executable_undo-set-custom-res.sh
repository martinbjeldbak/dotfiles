#!/bin/bash

source "$(dirname "$0")/lib.sh"
setup_hyprland

display=$(get_display)

if [ ! -f "$SUNSHINE_MONITOR_CACHE" ]; then
    echo "Error: no saved monitor state at $SUNSHINE_MONITOR_CACHE" >&2
    exit 1
fi

prev_mode=$(cat "$SUNSHINE_MONITOR_CACHE")
echo "Restoring ${display} to ${prev_mode}"
hyprctl keyword monitor "${display},${prev_mode},0x0,1,vrr,2"

echo "Starting hypridle"
systemctl --user start hypridle.service

echo "Switching to workspace 1"
hyprctl dispatch workspace 1
