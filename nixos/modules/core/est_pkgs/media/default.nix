{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    mpv
    qimgv
    zathura
    fooyin
    bitwarden
  ];
}
