#!/bin/bash

# NOTE:create user/groups (for minimalistic distro)
chmod +x "$(pwd)"/user.sh
# source "$(pwd)"/user.sh

# NOTE:install packages 
chmod +x "$(pwd)"/packages.sh
source "$(pwd)"/packages.sh

# NOTE:import dotfiles
git clone --recurse-submodules https://github.com/HeRo3S/dotfiles.git
stow ./dotfiles -t ~/ 

# TODO:setup X11/wayland
# TODO:setup windows manager
# TODO:setup services/deamon
