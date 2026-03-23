{ config, pkgs, inputs, ... }:

let
  pkgs2505 = import inputs.nixpkgs-2505 {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      # Runtime dependendies
      fzf
      ripgrep
      gnumake
      gcc
      luajit
      tree-sitter

      # Packages manager for mason
      cargo

      #Formatters
      stylua

      # Precommit
      husky

      # Codeium
      pkgs2505.codeium
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/nvim/");
}
