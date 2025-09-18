{ config, pkgs, lib, ... }:

{
  imports = [ ./git ./nvim ./tmux ./mcp ];
}
