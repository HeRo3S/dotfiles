{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    darkman
    dconf
    hyprsunset
  ];

  xdg.configFile."darkman/config.yaml".text = ''
    lat: 10.8231
    lng: 106.6297
    dbusserver: true
    portal: true
  '';

  xdg.dataFile."dark-mode.d/theme.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      exec ${pkgs.hyprland}/bin/hyprctl hyprsunset temperature 4200
    '';
    executable = true;
  };

  xdg.dataFile."light-mode.d/theme.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      exec ${pkgs.hyprland}/bin/hyprctl hyprsunset identity
    '';
    executable = true;
  };

  home.activation.initializeTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "$HOME/.config/waybar/themes/current.css" ] \
      || [ ! -e "$HOME/.config/rofi/themes/catppuccin-current.rasi" ] \
      || [ ! -e "$HOME/.config/kitty/theme-current.conf" ]; then
      "${config.customVars.dotfilesDir}/scripts/theme/apply-theme.sh" dark || true
    fi
  '';

  systemd.user.services.darkman = {
    Unit = {
      Description = "Dark mode transition service";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.darkman}/bin/darkman run";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "default.target" "graphical-session.target" ];
  };

  systemd.user.services.hyprsunset = {
    Unit = {
      Description = "Hyprland blue light filter";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "default.target" "graphical-session.target" ];
  };
}
