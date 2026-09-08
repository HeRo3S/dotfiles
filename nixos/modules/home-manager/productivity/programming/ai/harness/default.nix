{ inputs, pkgs, ... }:

{
  imports = [ ./opencode ./claude ./t3code ];

  _module.args.harnessPkgs = import inputs.nixpkgs-bleeding-edge {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
}
