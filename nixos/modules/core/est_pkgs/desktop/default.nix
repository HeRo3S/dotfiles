{ config, pkgs, lib, ... }:

{
  services.displayManager.ly = { enable = true; };

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    lshw
    dunst
    kitty
    waybar
    wofi
    brightnessctl
    playerctl
    pavucontrol
    helvum
  ];
}
