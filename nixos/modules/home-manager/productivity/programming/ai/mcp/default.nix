{ config, pkgs, lib, inputs, ... }: {
  home.packages = [ inputs.mcphub-nvim.packages.${pkgs.system}.default ];
}
