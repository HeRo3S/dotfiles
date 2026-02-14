{ config, pkgs, lib, ... }:

{
  services.openssh.enable = true;
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
    unrar
    p7zip
    gnutar
    gnumake
    socat
    jq
    fzf
    git
    gh
    glab
    wl-clipboard
    htop
    gpustat
    intel-gpu-tools
    neofetch
    neovim
    tmux
    ffmpeg-full
    tcpdump
    iproute2
    dig
  ];
}
