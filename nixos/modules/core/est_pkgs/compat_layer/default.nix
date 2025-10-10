{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
    bottles
    dxvk
    protonup-qt
  ];
}
