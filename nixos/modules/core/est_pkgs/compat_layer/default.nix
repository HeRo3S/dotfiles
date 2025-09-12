{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
    # # native wayland support (unstable)
    # wineWowPackages.waylandFull

    bottles
    dxvk
  ];
}
