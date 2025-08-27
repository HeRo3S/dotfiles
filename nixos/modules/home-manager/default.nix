{ config, pkgs, lib, ... }:

{
  imports = [ ./variables.nix ];

  home.file = {
    "keybinds".source = config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/keybinds/");
    "scripts".source = config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/scripts/");
  };

  # fonts
  home.packages = with pkgs; [
    pkgs.nerd-fonts.iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    corefonts
    vista-fonts
  ];
  fonts.fontconfig.enable = true;
}
