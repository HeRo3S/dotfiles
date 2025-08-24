{ config, pkgs, lib, ... }:

{
  options.customVars = with lib.types; {
    dotfilesDir = lib.mkOption {
      type = str;
      description = "The default dotfiles directory.";
    };
  };

  config.customVars = {
    dotfilesDir = "${config.home.homeDirectory}/personal/dotfiles";
  };
}
