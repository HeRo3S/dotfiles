{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.customCfg.isLaptop {
    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
