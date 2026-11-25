{ config, pkgs, lib, ... }:

{
  imports = [ ./calibre ];
  home.packages = with pkgs; [
    obs-studio
    gimp3
    krita
    godot
    reaper
    yabridge
    yabridgectl
    guitarix
    decent-sampler
    kdePackages.kdenlive
  ];
}
