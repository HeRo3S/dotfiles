{ config, pkgs, inputs, lib, ... }:

{
  imports = [ inputs.steam-presence.nixosModules.steam-presence ./sunshine.nix ];
  environment.systemPackages = with pkgs; [
    firefox
    mpv
    qimgv
    zathura
    bitwarden-desktop
    bitwarden-cli
    mesa
    mangohud
  ];
  # Need to install globally cause i'm too lazy to extract the module
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    presence = {
      enable = true;
      steamApiKeyFile = config.age.secrets.steamAPI.path;
      userIds = [ "76561198404888285" ];
    };
  };
  systemd.user.services.steam-presence.serviceConfig.WorkingDirectory = lib.mkForce "%h";

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
