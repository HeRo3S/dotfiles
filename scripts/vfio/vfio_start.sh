#!/usr/bin/env bash

# Get list of inactive VMs (requires sudo)
virsh_list_output=$(sudo virsh list --all --inactive 2>/dev/null)
if [[ $? -ne 0 ]]; then
    echo "Failed to get VM list. Check sudo access."
    exit 1
fi

# Skip header lines and pass to fzf
selected=$(echo "$virsh_list_output" | tail -n +3 | fzf)
if [[ -z "$selected" ]]; then
    exit 0
fi

# Extract VM name (assumes standard virsh output format)
selected_name=$(echo "$selected" | awk '{print $2}')
echo "Starting $selected_name"

# Start the VM
sudo virsh start "$selected_name"

sudo systemd-tmpfiles --create

looking-glass-client -s -m 97
