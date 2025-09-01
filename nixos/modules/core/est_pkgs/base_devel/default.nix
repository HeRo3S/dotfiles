{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    libgcc
    cmake
    cargo
    ripgrep
    tree-sitter
    wget
    curl
    unzip
    gnutar
    jq
    fzf
    git
    htop
    neofetch
    neovim
    tmux
    ffmpeg-full
  ];
}
