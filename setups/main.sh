#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
parent_dir=$(dirname "$script_dir")

# NOTE:create user/groups (for installation without creating account before)
read -r -p "Do you want to create a user account? (y/n): " create_account

if [[ $create_account == "y" || $create_account == "Y" ]]; then
    chmod +x "$script_dir"/user.sh
    "$script_dir"/user.sh
fi

# NOTE:install packages 
chmod +x "$script_dir"/packages.sh
"$script_dir"/packages.sh

# NOTE:import dotfiles
cd "$parent_dir" && stow . -t "${HOME}" || return
git submodule update --init --recursive

chmod +x "$parent_dir"/scripts/tmux.sh

# TODO:setup X11/wayland
# TODO:setup windows manager
# TODO:setup services/deamon

