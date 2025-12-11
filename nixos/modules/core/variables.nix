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
      intel = {
        enable = lib.mkEnableOption "intel";
        isLegacyDevice = lib.mkEnableOption "legacy Intel devices";
      };
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
        enable = lib.mkDefault true;
        discreteGpuBusId = lib.mkDefault "PCI:1@0:0:0";
        onboardGpuBusId = lib.mkDefault "PCI:0@0:2:0";
      };
      intel = {
        enable = lib.mkDefault true;
        isLegacyDevice = lib.mkDefault false;
      };
    };
    bluetooth.enable = lib.mkDefault true;
    isLaptop = lib.mkDefault true;
    vfio = {
      enable = lib.mkDefault true;
      vfioPciDevices = lib.mkDefault [ "10de:1f91" "10de:10fa" ];
    };
    containers = {
      docker = lib.mkDefault true;
      podman = lib.mkDefault false;
    };
    user = { name = lib.mkDefault "amelia"; };
  };
}
