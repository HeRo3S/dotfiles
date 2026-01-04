{ config, lib, pkgs, ... }:

{
  imports = [ ./looking-glass.nix ];

  config = lib.mkIf config.customCfg.vfio.enable {
    boot.initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];

    boot.kernelParams = [
      "${if config.customCfg.vfio.amdCpu then
        "amd_iommu=on"
      else
        "intel_iommu=on"}"
      "iommu=pt"
      "vfio-pci.ids=${
        lib.concatStringsSep "," config.customCfg.vfio.vfioPciDevices
      }"
    ];

    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
