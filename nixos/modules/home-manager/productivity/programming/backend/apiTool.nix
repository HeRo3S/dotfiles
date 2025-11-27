{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs;
    if config.customHomeCfg.programming.apiTool.openSource then
      [ insomnia ]
    else
      [ postman ];
}
