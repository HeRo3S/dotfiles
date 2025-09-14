{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.graphics.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    # services.supergfxd = {
    #   enable = true;
    #   settings = {
    #     mode = "Hybrid";
    #     vfio_enable = true;
    #     vfio_save = true;
    #     hotplug_type = "Asus";
    #     compute_save = false;
    #     always_reboot = false;
    #     no_logind = false;
    #     logout_timeout_s = 180;
    #   };
    # };

    hardware.graphics.enable = true;

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
        intelBusId = config.customCfg.graphics.nvidia.onboardGpuBusId;
        nvidiaBusId = config.customCfg.graphics.nvidia.discreteGpuBusId;
      };
    };
  };
}
