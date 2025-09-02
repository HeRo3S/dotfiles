#!/usr/bin/bash
#Alias
alias dev_tmux='~/scripts/dev-tmux.sh'
alias tmux-ready='~/scripts/tmux-ready.sh'
alias cursor='/opt/cursor.appimage'
alias hows-my-gpu='echo "NVIDIA Dedicated Graphics" | grep "NVIDIA" && lspci -nnk | grep "NVIDIA Corporation TU117M" -A 2 | grep "Kernel driver in use" && echo "Intel Integrated Graphics" | grep "Intel" && lspci -nnk | grep "Intel.*GT2" -A 3 | grep "Kernel driver in use" && echo "Enable and disable the dedicated NVIDIA GPU with nvidia-enable and nvidia-disable"'
alias nvidia-enable='~/scripts/vfio/vfio_unbind.sh'
alias nvidia-disable='~/scripts/vfio/vfio_bind.sh'
