{ config, pkgs, lib, ... }:

{
  imports = [ ./calibre ];
  home.packages = with pkgs; [
    obs-studio
    gimp3
    krita
    reaper
    yabridge
    yabridgectl
    guitarix
    decent-sampler
    kdePackages.kdenlive
  ];
}
