{ config, pkgs, lib, ... }:

{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [ xfce.thunar lf ];
}
