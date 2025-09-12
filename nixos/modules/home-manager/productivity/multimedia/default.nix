{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    gimp3
    krita
    reaper
    yabridge
    yabridgectl
    kdePackages.kdenlive
  ];
}
