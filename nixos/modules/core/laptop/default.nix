{ config, lib, ... }:

{
  imports = [ ./battery ./trackpad ];

  services.logind.settings.Login = lib.mkIf config.customCfg.isLaptop {
    HandleLidSwitch = "hybrid-sleep";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}
