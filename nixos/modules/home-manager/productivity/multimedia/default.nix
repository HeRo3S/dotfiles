{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    gimp3
    krita
    reaper
    yabridge
    yabridgectl
    guitarix
    decent-sampler
    calibre
    kdePackages.kdenlive
  ];
}
