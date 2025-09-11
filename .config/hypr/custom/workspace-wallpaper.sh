#!/usr/bin/env bash

# Create a lock file to ensure only one instance runs
LOCKFILE="/tmp/workspace-wallpaper.lock"
LOCKFD=99

# Function to cleanup lock file
cleanup() {
    rm -f "$LOCKFILE"
    exit
}

# Trap exit signals to ensure cleanup
trap cleanup EXIT SIGINT SIGTERM

# Try to acquire lock
if ! eval "exec $LOCKFD>$LOCKFILE"; then
    echo "Failed to acquire lock"
    exit 1
fi

# Non-blocking lock - if we can't get it immediately, another instance is running
if ! flock -n $LOCKFD; then
    echo "Another instance is already running"
    exit 0
fi

if ! command -v linux-wallpaperengine &>/dev/null; then
    echo "Error: linux-wallpaperengine is not installed or not in PATH"
    echo "Please install it or check your PATH environment variable"
    exit 1
fi

# Define your wallpapers per workspace
declare -A WALLPAPERS=(
    # asuka
    [1]="3324181838"
    # whiteish
    [2]="3391355116"
    [3]="2964778792"
    [4]="3537802173"
    # punishing gray raven
    [5]="3313102203"
    # violet
    [6]="2645609166"
    # kitan
    [7]="3344732182"
    # bang
    [8]="3424923938"
    # violet
    [9]="3379081947"
    # Add more as needed
)

setwallpaper() {
    local workspace_id="$1"
    echo "Setting wallpaper for workspace: $workspace_id"

    # Kill any existing wallpaperengine processes for this screen
    pkill -f "linux-wallpaperengine.*--screen-root eDP-1"

    if [[ -n "${WALLPAPERS[$workspace_id]}" ]]; then
        linux-wallpaperengine --silent --screen-root eDP-1 --scaling fill --fps 10 "${WALLPAPERS[$workspace_id]}" &
    else
        linux-wallpaperengine --silent --screen-root eDP-1 --scaling fill --fps 10 "${WALLPAPERS[1]}" &
    fi
}

CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')
setwallpaper "$CURRENT_WS"

socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
    while read -r event; do
        if [[ $event == "workspace>>"* ]]; then
            WORKSPACE_ID="${event#workspace>>}"
            setwallpaper "$WORKSPACE_ID"
        fi
    done
