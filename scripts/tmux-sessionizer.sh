#!/usr/bin/env bash

selected=$(find ~/Projects -mindepth 1 -maxdepth 1 -type d | fzf)
if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr ":,. " "____")

switch_to() {
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    fi
}

if tmux has -t="$selected_name" 2 >/dev/null; then
    switch_to
    exit 0;
else
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux send-keys -t "$selected_name" "tmux-ready" ^m
    switch_to
fi
