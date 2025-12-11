{ config, pkgs, lib, ... }:

{
  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/.gitconfig");
  };
}
