#!/usr/bin/env bash

if [[ -x ./tmux-ready.sh ]]; then
    ./tmux-ready.sh
    exit 0
fi

tmux new-window
tmux split-window -v
tmux resize-pane -D 10
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 0

tmux select-window -t 1
fnm use default
nvim .
