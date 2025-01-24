# Dotfiles

## Descrpition
A collection of system dotfiles and setup scripts for Linux distros.
All packages that will be installed:

- Through nix:
    - ZSH
    - Gnu/Stow
    - Tmux
    - Neovim
    - Firefox
    - FZF
- Through curl:
    - FNM
    - Starship.rs
- Some ZSH plugins:
    - Autosuggestion/ Autocompletion
    - Syntax highlighting
    - ZSH vi mode

## Usage
For minimalistic distros like Arch or Gentoo that don't create user account when you successfully install them, use the create account options.
If not, skip the account creating process.

```sh
git clone --recursive https://github.com/HeRo3S/dotfiles
cd dotfiles
chmod +x setups/main.sh
./setups/main.sh
```
