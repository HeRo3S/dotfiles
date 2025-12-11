{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    mpv
    qimgv
    zathura
    bitwarden-desktop
    bitwarden-cli
  ];
  # Need to install globally cause i'm too lazy to extract the module
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;
}
