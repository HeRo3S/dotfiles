{ config, pkgs, ... }:

{
  home.packages = [ pkgs.starship ];

  home.file = {
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/.config/starship.toml");
  };
}
