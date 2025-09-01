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
    socat
    jq
    fzf
    git
    xclip
    htop
    neofetch
    neovim
    tmux
    ffmpeg-full
  ];
}
