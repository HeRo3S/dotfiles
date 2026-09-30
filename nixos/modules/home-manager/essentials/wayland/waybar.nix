{ config, pkgs, ... }:

{
  home.packages = [ pkgs.cantarell-fonts pkgs.font-awesome_5 ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  systemd.user.services.waybar.Install.WantedBy = [ "default.target" ];

  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink
    ("${config.customVars.dotfilesDir}/.config/waybar");
}
