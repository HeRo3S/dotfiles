#!/usr/bin/env bash

set -x
MONITOR="HDMI-A-1"
STATE=$(hyprctl monitors | grep -A 20 "$MONITOR" | grep "disabled" | wc -l)

if [ "$STATE" -gt 0 ]; then
    # Disable monitor
    hyprctl keyword monitor "$MONITOR, disable"
else
    # Enable monitor
    hyprctl keyword monitor "$MONITOR, 1920x1080@60, 1920x0, 1"
fi

exit 0;
