{ config, lib, ... }:

{
  options.customCfg = {
    nvidia.enable = lib.mkEnableOption "nvidia";
    bluetooth.enable = lib.mkEnableOption "bluetooth";
  };

  config.customCfg = {
    nvidia.enable = true;
    bluetooth.enable = true;
  };
}
