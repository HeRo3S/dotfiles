#!/usr/bin/zsh
#Functions
function zle_eval {
    echo -en "\e[2K\r"
    eval "$@"
    zle redisplay
}

function tmux-sessionizer {
    zle_eval source $HOME/scripts/tmux-sessionizer.sh
}
zle -N tmux-sessionizer; 


