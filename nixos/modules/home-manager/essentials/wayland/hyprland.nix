{ config, pkgs, ... }:

{
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/hypr");
  home.packages = with pkgs; [ linux-wallpaperengine hyprshot ];
  home.sessionVariables = { HYPRSHOT_DIR = "Pictures/screenshot"; };

  systemd.user.services.dunst = {
    Unit = {
      Description = "Notification daemon";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" "graphical-session.target" ];
  };
}
