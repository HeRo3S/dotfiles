{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils
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
    wl-clipboard
    htop
    gpustat
    intel-gpu-tools
    neofetch
    neovim
    tmux
    ffmpeg-full
  ];
}
