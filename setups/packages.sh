#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon
echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf
source "${HOME}"/.bashrc

packages=(
    zsh
    stow
    tmux
    neovim
    fzf
    firefox
)

for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    nix-env -iA nixpkgs."$pkg"
done

echo "All packages installed successfully."

# NOTE: we don't use OMZ anymore, install zsh plugins like a sane person did
mkdir "${HOME}"/.zsh
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh/zsh-nvm
# NOTE: and a good prompt written in Rust
curl -sS https://starship.rs/install.sh | sh

# NOTE: setup nvm and node 
PROFILE=/dev/null bash -c 'curl -fsSL https://fnm.vercel.app/install | bash'
fnm install --lts

NVM_GLOBAL_PACKAGES=(tree-sitter-cli)
for nvmPkg in "$NVM_GLOBAL_PACKAGES"; do
    echo "Installing $nvmPkg..."
    npm install -g $NVM_GLOBAL_PACKAGES
done

