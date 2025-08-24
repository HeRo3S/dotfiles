{ config, pkgs, lib, ... }:

{
  imports = [
      ./variables.nix
  ];

  home.file = {
    "keybinds".source = config.lib.file.mkOutOfStoreSymlink("${config.customVars.dotfilesDir}/keybinds/");
    "scripts".source = config.lib.file.mkOutOfStoreSymlink("${config.customVars.dotfilesDir}/scripts/");
  };
}
