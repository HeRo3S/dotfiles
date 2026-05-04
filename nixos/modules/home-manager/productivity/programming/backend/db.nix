{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [ sqlit-tui ];
}
