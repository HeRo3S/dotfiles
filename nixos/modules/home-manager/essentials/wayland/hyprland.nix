{ config, pkgs, ... }:

{
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/hypr");
  home.packages = with pkgs; [ linux-wallpaperengine hyprshot ];
  home.sessionVariables = { HYPRSHOT_DIR = "Pictures/screenshot"; };
}
