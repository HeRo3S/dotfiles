{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ steam vesktop ani-cli qbittorrent jamesdsp ];
}
