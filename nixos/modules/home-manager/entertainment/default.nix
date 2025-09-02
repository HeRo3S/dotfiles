{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    vesktop
    ani-cli
    qbittorrent
    jamesdsp
    moonlight-qt
  ];
  xdg.configFile."vesktop/themes".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/vesktop/themes");
}
