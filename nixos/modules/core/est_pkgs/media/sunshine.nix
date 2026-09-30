{ config, ... }:

{
  services.sunshine = {
    enable = config.customCfg.sunshine.enable;
    openFirewall = config.customCfg.sunshine.enable;
  };
}
