{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ rofi-unwrapped ];
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/rofi");
}
