{ config, pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/hypr/hyprland.conf");
}
