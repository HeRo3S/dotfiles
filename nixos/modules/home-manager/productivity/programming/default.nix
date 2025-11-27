{ config, pkgs, lib, ... }:

{
  imports = [ ./git ./nvim ./tmux ./ai ./backend ];
}
