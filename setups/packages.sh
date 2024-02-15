#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon
bash
echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf

packages=(
    zsh
    stow
    tmux
    neovim
    firefox-unwrapped
)

for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    nix-env -iA nixpkgs."$pkg"
done

echo "All packages installed successfully."

# NOTE: setup oh-my-zsh and theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

# NOTE: setup nvm and node 
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

