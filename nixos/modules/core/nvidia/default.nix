{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };
  };
}
