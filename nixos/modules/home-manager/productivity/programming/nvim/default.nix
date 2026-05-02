{ config, pkgs, pkgs2505, ... }: {
  home.packages = with pkgs; [
    neovim

    # Runtime dependendies
    fzf
    ripgrep
    gnumake
    gcc
    luajit
    tree-sitter
    nodejs

    # Packages manager for mason
    cargo

    #Formatters
    stylua

    # Precommit
    husky

    # Codeium
    pkgs2505.codeium
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/nvim/");
}
