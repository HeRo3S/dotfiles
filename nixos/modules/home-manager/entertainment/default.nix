{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    vesktop
    ani-cli
    qbittorrent
    jamesdsp
    moonlight-qt
    lsfg-vk
    lsfg-vk-ui
    xivlauncher
  ];
  xdg.configFile."vesktop/themes".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/vesktop/themes");

  systemd.user.services.jamesdsp = {
    Unit = {
      Description = "JamesDSP audio effects";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.jamesdsp}/bin/jamesdsp --tray";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" "graphical-session.target" ];
  };
}
