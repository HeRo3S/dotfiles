{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.customCfg.graphics.intel.enable {
    boot = {
      kernelParams = [
        # Only needed for low-power encoding modes. Not 100% sure but I think
        # that the UHD 630 only supports low-power encode for h264
        "i915.enable_guc=2"
      ];
    };
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          #vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
          # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
          intel-media-driver
          libva-vdpau-driver
          intel-compute-runtime-legacy1
        ];
        extraPackages32 = with pkgs.driversi686Linux; [
          intel-media-driver
          libva-vdpau-driver
        ];
      };
    };
  };
}
