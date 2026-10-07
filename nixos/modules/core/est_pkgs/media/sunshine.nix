{ config, pkgsNightly, ... }:

{
  services.sunshine = {
    enable = config.customCfg.sunshine.enable;
    openFirewall = config.customCfg.sunshine.enable;
    capSysAdmin = true;
    package = pkgsNightly.sunshine;
  };
}
