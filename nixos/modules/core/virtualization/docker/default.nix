{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.containers.docker {
    # In /etc/nixos/configuration.nix
    virtualisation.docker = { enable = true; };

    # Optional: Add your user to the "docker" group to run docker without sudo
    users.users."${config.customCfg.user.name}".extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
