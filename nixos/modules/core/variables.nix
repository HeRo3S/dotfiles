{ config, lib, ... }:

{
  options.customCfg = with lib.types; {
    graphics = {
      nvidia = {
        enable = lib.mkEnableOption "nvidia";
        discreteGpuBusId = lib.mkOption {
          type = str;
          description = "The discrete GPU bus ID.";
        };
        onboardGpuBusId = lib.mkOption {
          type = str;
          description = "The onboard GPU bus ID.";
        };
      };
      intel.enable = lib.mkEnableOption "intel";
    };
    bluetooth.enable = lib.mkEnableOption "bluetooth";
    isLaptop = lib.mkEnableOption "laptop";
    vfio = {
      enable = lib.mkEnableOption "vfio";
      vfioPciDevices = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of vfio pci devices.";
      };
    };
    containers = {
      docker = lib.mkEnableOption "docker";
      podman = lib.mkEnableOption "podman";
    };
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Username";
      };
    };
  };

  config.customCfg = {
    graphics = {
      nvidia = {
        enable = true;
        discreteGpuBusId = "PCI:1:0:0";
        onboardGpuBusId = "PCI:0:2:0";
      };
      intel.enable = true;
    };
    bluetooth.enable = true;
    isLaptop = true;
    vfio = {
      enable = true;
      vfioPciDevices = [ "10de:1f91" "10de:10fa" ];
    };
    containers = {
      docker = false;
      podman = true;
    };
    user = { name = "amelia"; };
  };
}
