{ config, pkgs, lib, ... }:

{
  options.customVars = with lib.types; {
    dotfilesDir = lib.mkOption {
      type = str;
      description = "The default dotfiles directory.";
    };
  };

  options.customHomeCfg = with lib.types; {
    programming = {
      apiTool = {
        openSource = lib.mkEnableOption
          "Use open-source API tool (Insomnia) instead of Postman";
      };
    };
  };

  config = {
    customVars = {
      dotfilesDir =
        lib.mkDefault "${config.home.homeDirectory}/personal/dotfiles";
    };
    customHomeCfg = {
      programming = { apiTool.openSource = lib.mkDefault false; };
    };
  };
}
