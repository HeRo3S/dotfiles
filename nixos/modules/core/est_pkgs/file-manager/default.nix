{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [ xfce.thunar lf ];
}
