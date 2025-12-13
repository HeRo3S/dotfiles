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
  hardware.xone.enable = true;
  hardware.xpad-noone.enable = true;
  hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
    # connect xbox controller
  };
}
