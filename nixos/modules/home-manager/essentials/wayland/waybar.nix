{ config, pkgs, ... }:

{
  home.packages = [ pkgs.waybar pkgs.cantarell-fonts pkgs.font-awesome_5 ];

  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/waybar");
}
