{ pkgs, ... }:
let elc = pkgs.callPackage ./elc.nix { };
in { home.packages = [ elc ]; }
