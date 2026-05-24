#!/usr/bin/env bash
set -euo pipefail

state_file="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles/night-light"
mkdir -p "$(dirname "$state_file")"

current="off"
if [[ -f "$state_file" ]]; then
  current="$(<"$state_file")"
fi

if [[ "$current" == "on" ]]; then
  hyprctl hyprsunset identity >/dev/null
  printf 'off\n' >"$state_file"
else
  hyprctl hyprsunset temperature 4200 >/dev/null
  printf 'on\n' >"$state_file"
fi
