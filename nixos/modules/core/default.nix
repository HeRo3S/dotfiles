{ ... }:

{
  imports = [
    ./auth
    ./variables.nix
    ./i18n
    ./network
    ./bluetooth
    ./graphics
    ./laptop
    ./est_pkgs
    ./virtualization
    ./audio
  ];
}
