{ pkgs, ... }:
let qwen-code = pkgs.callPackage ./qwen-code.nix { };
in { home.packages = [ qwen-code ]; }
