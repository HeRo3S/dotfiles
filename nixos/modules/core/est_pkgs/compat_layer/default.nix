{ pkgs, pkgs2505, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.staging
    winetricks
    pkgs2505.bottles
    dxvk
    protonup-qt
  ];
  services.flatpak.enable = true;
}
