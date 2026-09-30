{ config, lib, ... }:

{
  config = lib.mkIf config.customCfg.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        experimental = true; # show battery
        # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
        # for pairing bluetooth controller
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
    };
    boot.extraModprobeConfig = "options btusb enable_autosuspend=0";
    services.blueman.enable = true;
  };
}
