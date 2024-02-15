#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
parent_dir=$(dirname "$script_dir")

# NOTE:create user/groups (for minimalistic distro)
chmod +x "$script_dir"/user.sh
# source "$(pwd)"/user.sh

# NOTE:install packages 
chmod +x "$script_dir"/packages.sh
source "$script_dir"/packages.sh

# NOTE:import dotfiles
stow "$parent_dir" -t ~/ 

# TODO:setup X11/wayland
# TODO:setup windows manager
# TODO:setup services/deamon
