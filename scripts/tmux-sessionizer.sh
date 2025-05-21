#!/usr/bin/env bash

selected=$(find ~/Projects ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
if [[ -z "$selected" ]]; then
    return 0
fi

selected_name=$(basename "$selected" | tr ":,. " "____")

switch_to() {
    if ! { [ "$TERM" = "tmux-256color" ] && [ -n "$TMUX" ]; }; then
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    fi
}

if tmux has -t="$selected_name" 2>/dev/null; then
    switch_to
    return 0
fi

tmux new-session -ds "$selected_name" -c "$selected"
tmux send-keys -t "$selected_name" "tmux-ready" ^m
switch_to
