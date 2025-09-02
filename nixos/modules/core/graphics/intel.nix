{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.graphics.intel.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      graphics = {
        enable = true;
        extraPackages = with pkgs;
          [
            #vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
            # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
            intel-media-sdk # for older GPUs
          ];
      };
    };
  };
}
