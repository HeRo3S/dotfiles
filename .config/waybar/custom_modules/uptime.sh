#!/usr/bin/env bash
UPTIME_PRETTY=$(uptime)

UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY" | sed 's/^.*up *//;s/, *[0-9]* user.*$//;s/ minutes\{0,1\}/m/;s/ hours\{0,1\}/h/;s/ days\{0,1\}/d/')

# Handle different formats based on your locale
if [[ $UPTIME_FORMATTED =~ ^[0-9]+:[0-9]+$ ]]; then
    # H:MM format from Vietnamese locale
    HOURS=$(echo "$UPTIME_FORMATTED" | cut -d: -f1)
    MINUTES=$(echo "$UPTIME_FORMATTED" | cut -d: -f2)
    if [ "$HOURS" -eq 0 ]; then
        UPTIME_FORMATTED="${MINUTES}m"
    elif [ "$MINUTES" -eq 0 ]; then
        UPTIME_FORMATTED="${HOURS}h"
    else
        UPTIME_FORMATTED="${HOURS}h${MINUTES}m"
    fi
elif [[ $UPTIME_FORMATTED =~ ^[0-9]+\ days?$ ]]; then
    # Handle days format
    UPTIME_FORMATTED=$(echo "$UPTIME_FORMATTED" | sed 's/ days\{0,1\}/d/')
else
    # Handle other formats (like "3 days, 2:15")
    UPTIME_FORMATTED=$(echo "$UPTIME_FORMATTED" | sed 's/ days\{0,1\}/d/;s/ hours\{0,1\}/h/;s/ minutes\{0,1\}/m/')
fi

echo " $UPTIME_FORMATTED"
