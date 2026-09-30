{ config, pkgs, lib, inputs, ... }:

{
  services.displayManager.ly = { enable = true; };
  services.displayManager.autoLogin = {
    enable = config.customCfg.autoLogin.enable;
    user = config.customCfg.user.name;
  };
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.xserver.desktopManager.runXdgAutostartIfNone = false;
  # Ly runs the shared session wrapper before UWSM sets this variable.
  services.xserver.displayManager.sessionCommands = ''
    export XDG_CURRENT_DESKTOP=Hyprland
  '';
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.uwsm.waylandCompositors.hyprland = {
    prettyName = "Hyprland";
    binPath = "/run/current-system/sw/bin/start-hyprland";
  };
  programs.hyprlock.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland darkman ];
    config.common = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
    };
  };

  powerManagement.powerDownCommands = ''
    ${pkgs.systemd}/bin/systemctl suspend
  '';

  services.logind.settings.Login = { HandlePowerKey = "suspend"; };

  systemd.services."hyprland-sleep-lock" = {
    description = "Lock screen before sleep";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    serviceConfig.ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
  };

  environment.systemPackages = with pkgs; [
    lshw
    dunst
    kitty
    waybar
    rofi-unwrapped
    darkman
    hyprsunset
    brightnessctl
    playerctl
    pavucontrol
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = lib.mkForce "wayland";
}
