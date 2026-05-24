#!/usr/bin/env bash
set -euo pipefail

state_file="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles/theme-mode"
current="dark"
if [[ -f "$state_file" ]]; then
  current="$(<"$state_file")"
fi

if [[ "$current" == "dark" ]]; then
  "${DOTFILES_DIR:-$HOME/personal/dotfiles}/scripts/theme/apply-theme.sh" light
else
  "${DOTFILES_DIR:-$HOME/personal/dotfiles}/scripts/theme/apply-theme.sh" dark
fi
