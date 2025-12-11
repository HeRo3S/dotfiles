{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    texlive.combined.scheme-full
    obsidian
  ];
}
