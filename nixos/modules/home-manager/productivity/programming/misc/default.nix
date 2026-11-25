{ config, pkgsNightly, lib, ... }:

{
  home.packages = with pkgsNightly; [ bootdev-cli ];
}
