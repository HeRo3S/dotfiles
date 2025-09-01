{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Runtime dependendies
      fzf
      ripgrep
      gnumake
      gcc
      luajit
      tree-sitter

      # Packages manager for mason
      nodejs_24
      cargo

      #Formatters
      stylua
    ];
  };
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/nvim/");
}
