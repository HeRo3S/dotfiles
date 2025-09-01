{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.customCfg.isLaptop {
    services.xserver.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
