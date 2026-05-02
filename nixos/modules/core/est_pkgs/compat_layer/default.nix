{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.staging
    winetricks
    dxvk
    protonup-qt
  ];
  services.flatpak.enable = true;
}
