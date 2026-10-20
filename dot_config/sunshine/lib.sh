#!/bin/bash

SUNSHINE_MONITOR_CACHE="/tmp/sunshine-monitor-state-$(id -u)"

setup_hyprland() {
    if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
        HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/"$(id -u)"/hypr/ 2>/dev/null | head -n1)
        export HYPRLAND_INSTANCE_SIGNATURE
    fi
    if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
        echo "Error: no Hyprland instance found" >&2
        exit 1
    fi
}

get_display() {
    hyprctl monitors all | awk '/^Monitor/{print $2; exit}'
}
