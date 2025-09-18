{ config, pkgs, lib, inputs, ... }:

{
  # services.displayManager.ly = { enable = true; };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

  powerManagement.powerDownCommands = ''
    ${pkgs.systemd}/bin/systemctl suspend
  '';

  services.logind = { powerKey = "suspend"; };

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
    rofi-wayland-unwrapped
    brightnessctl
    playerctl
    pavucontrol
    helvum
  ];
}
