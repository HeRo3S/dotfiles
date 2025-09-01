{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.agave
    pkgs.nerd-fonts.meslo-lg
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    corefonts
    vista-fonts
  ];
  fonts.fontconfig.enable = true;
}
