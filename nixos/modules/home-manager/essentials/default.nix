{ config, pkgs, lib, ... }:

{
  imports = [ ./font ./kitty ./shell ./wayland ];
}
