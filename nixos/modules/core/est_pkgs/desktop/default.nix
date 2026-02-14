{ config, pkgs, lib, inputs, ... }:

{
  services.displayManager.ly = { enable = true; };
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

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
    brightnessctl
    playerctl
    pavucontrol
    helvum
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = lib.mkForce "wayland";
}
