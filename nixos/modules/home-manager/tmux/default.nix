{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.tmux ];

  home.file = {
      ".tmux".source = config.lib.file.mkOutOfStoreSymlink("${config.customVars.dotfilesDir}/.tmux");
      ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink("${config.customVars.dotfilesDir}/.tmux.conf");
  };
}
