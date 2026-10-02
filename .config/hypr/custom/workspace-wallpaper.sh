#!/usr/bin/env bash

# Override WORKSPACE_WALLPAPER_CONFIG to use another Bash configuration file.
CONFIG_FILE="${WORKSPACE_WALLPAPER_CONFIG:-$(dirname -- "${BASH_SOURCE[0]}")/workspace-wallpaper.conf}"
if ! source "$CONFIG_FILE"; then
    echo "Error: could not load wallpaper config: $CONFIG_FILE" >&2
    exit 1
fi

# Keep the lock file: unlinking it lets another instance lock a different inode.
trap 'exit' SIGINT SIGTERM

# Try to acquire lock
if ! exec {LOCKFD}>"$LOCKFILE"; then
    echo "Failed to acquire lock"
    exit 1
fi

# Non-blocking lock - if we can't get it immediately, another instance is running
if ! flock -n "$LOCKFD"; then
    echo "Another instance is already running"
    exit 0
fi

if ! command -v linux-wallpaperengine &>/dev/null; then
    echo "Error: linux-wallpaperengine is not installed or not in PATH"
    echo "Please install it or check your PATH environment variable"
    exit 1
fi

declare -A ACTIVE_WALLPAPERS

stopwallpaper() {
    local monitor="$1"
    pkill -f "linux-wallpaperengine.*--screen-root[[:space:]]${monitor}([[:space:]]|$)" || true
}

setwallpaper() {
    local workspace_id="$1"
    local monitor="$2"
    echo "Setting wallpaper for workspace: $workspace_id on monitor: $monitor"

    # Kill any existing wallpaperengine processes for this screen
    stopwallpaper "$monitor"

    linux-wallpaperengine --silent --screen-root "$monitor" --scaling "$WALLPAPER_SCALING" --fps "$WALLPAPER_FPS" \
        "${WALLPAPERS[$workspace_id]:-$DEFAULT_WALLPAPER}" {LOCKFD}>&- &
}

syncwallpapers() {
    local force="${1:-false}"
    local monitors assignments monitor workspace_id
    local -A connected=()

    monitors=$(hyprctl monitors -j) || return
    assignments=$(jq -r '.[] | select(.disabled != true and .activeWorkspace.id > 0) |
        [.name, .activeWorkspace.id] | @tsv' <<< "$monitors") || return

    while IFS=$'\t' read -r monitor workspace_id; do
        [[ -n "$monitor" ]] || continue
        connected["$monitor"]=1
        if [[ "$force" == true || "${ACTIVE_WALLPAPERS[$monitor]}" != "$workspace_id" ]]; then
            setwallpaper "$workspace_id" "$monitor"
            ACTIVE_WALLPAPERS["$monitor"]="$workspace_id"
        fi
    done <<< "$assignments"

    for monitor in "${!ACTIVE_WALLPAPERS[@]}"; do
        if [[ -z "${connected[$monitor]}" ]]; then
            stopwallpaper "$monitor"
            unset 'ACTIVE_WALLPAPERS[$monitor]'
        fi
    done
}

syncwallpapers

while IFS= read -r event; do
    case "$event" in
        workspacev2\>\>*|moveworkspacev2\>\>*|focusedmonv2\>\>*)
            syncwallpapers
            ;;
        monitoradded\>\>*|monitorremoved\>\>*|configreloaded\>\>*)
            # Let workspace migration settle before querying the new layout.
            sleep "$MONITOR_SETTLE_DELAY"
            syncwallpapers true
            ;;
    esac
done < <(socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - {LOCKFD}>&-)
