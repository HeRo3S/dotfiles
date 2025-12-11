{ config, pkgs, lib, inputs, ... }: {
  home.packages = [ inputs.mcphub-nvim.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
