{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.containers.podman {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      package = pkgs.podman;
    };
    users.users."${config.customCfg.user.name}" = {
      isNormalUser = true;
      extraGroups = [ "podman" ];
    };
    environment.systemPackages = with pkgs; [ podman-compose podlet ];
  };
}
