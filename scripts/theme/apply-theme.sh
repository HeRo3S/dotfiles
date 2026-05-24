#!/usr/bin/env bash
set -euo pipefail

mode="${1:-}"
if [[ "$mode" != "dark" && "$mode" != "light" ]]; then
  printf 'usage: %s dark|light\n' "$0" >&2
  exit 2
fi

dotfiles_dir="${DOTFILES_DIR:-$HOME/personal/dotfiles}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles"
mkdir -p "$cache_dir"
printf '%s\n' "$mode" >"$cache_dir/theme-mode"

install_theme_file() {
  local src="$1"
  local dst="$2"

  if [[ -f "$src" ]]; then
    install -Dm644 "$src" "$dst"
  fi
}

apply_gtk() {
  local prefer_dark=0
  local color_scheme='prefer-light'

  if [[ "$mode" == "dark" ]]; then
    prefer_dark=1
    color_scheme='prefer-dark'
  fi

  mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"

  cat >"$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-application-prefer-dark-theme=$prefer_dark
EOF

  cat >"$HOME/.config/gtk-4.0/settings.ini" <<EOF
[Settings]
gtk-application-prefer-dark-theme=$prefer_dark
EOF

  if command -v dconf >/dev/null 2>&1; then
    dconf write /org/gnome/desktop/interface/color-scheme "'$color_scheme'" || true
  fi
}

apply_waybar() {
  install_theme_file \
    "$dotfiles_dir/.config/waybar/themes/$mode.css" \
    "$HOME/.config/waybar/themes/current.css"

  if command -v waybar >/dev/null 2>&1 && [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    waybar_pids() {
      pgrep -u "$(id -u)" -f '(^|/| )(.waybar-wrapped|waybar)( |$)' || true
    }

    pids="$(waybar_pids)"
    if [[ -n "$pids" ]]; then
      kill -TERM $pids >/dev/null 2>&1 || true
    fi

    for _ in {1..30}; do
      if [[ -z "$(waybar_pids)" ]]; then
        break
      fi
      sleep 0.1
    done

    pids="$(waybar_pids)"
    if [[ -n "$pids" ]]; then
      kill -KILL $pids >/dev/null 2>&1 || true
    fi

    waybar >/tmp/waybar.log 2>&1 &
    disown
  fi
}

apply_rofi() {
  install_theme_file \
    "$dotfiles_dir/.config/rofi/themes/catppuccin-$mode.rasi" \
    "$HOME/.config/rofi/themes/catppuccin-current.rasi"
}

apply_kitty() {
  install_theme_file \
    "$dotfiles_dir/.config/kitty/theme-$mode.conf" \
    "$HOME/.config/kitty/theme-current.conf"
}

apply_gtk
apply_waybar
apply_rofi
apply_kitty
