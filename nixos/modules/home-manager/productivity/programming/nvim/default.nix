{
  config,
  pkgs,
  pkgs2505,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      # Runtime dependencies
      fzf
      ripgrep
      gnumake
      gcc
      luajit
      tree-sitter

      # Language servers
      lua-language-server
      typescript-language-server
      vtsls
      vue-language-server
      pyright
      rust-analyzer
      gopls
      tailwindcss-language-server
      clang-tools
      texlab

      # Formatters
      stylua
      python3Packages.autopep8
      shfmt
      texlivePackages.latexindent
      prettierd
      prettier
      djlint
      php83Packages.php-cs-fixer
      nixfmt

      # Linters
      python3Packages.flake8
      shellcheck
      texlivePackages.chktex
      eslint_d

      # Debug adapters
      vscode-js-debug

      # Codeium
      pkgs2505.codeium
    ];
    extraWrapperArgs = [
      "--set"
      "VUE_LANGUAGE_SERVER_PATH"
      "${pkgs.vue-language-server}/lib/language-tools/packages/language-server"
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink (
    "${config.customVars.dotfilesDir}/.config/nvim/"
  );

}
