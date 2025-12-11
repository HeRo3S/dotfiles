{ inputs, pkgs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.twilight ];
  programs.zen-browser.enable = true;
  home.packages = [ pkgs.chromium ];
}
