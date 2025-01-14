#!/bin/sh

# tmux send-keys 'fnm use default' C-m 'nvim .' C-m

tmux new-window
tmux split-window -v
tmux resize-pane -D 10
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 0

tmux select-window -t 1
fnm use default
nvim .
