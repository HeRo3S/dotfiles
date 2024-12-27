#!/bin/sh

tmux new-session -d
tmux send-keys 'fnm use default'  C-m 'nvim .' C-m

tmux new-window
tmux split-window -v
tmux select-pane -t 0
tmux resize-pane -D 40
tmux split-window -h
tmux select-pane -t 0

# tmux select-window -t 1

tmux -2 attach-session -d
