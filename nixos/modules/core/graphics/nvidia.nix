{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.graphics.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = config.customCfg.graphics.nvidia.discreteGpuBusId;
        nvidiaBusId = config.customCfg.graphics.nvidia.onboardGpuBusId;
      };
    };
  };
}
