{ config, pkgs, lib, inputs, ... }:
let
  wrappedOpencode = pkgs.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
    '';
  };
  opencodeFiles = [ "opencode.json" "tui.json" "skills" ];
in {
  home.packages = [ wrappedOpencode ];
  xdg.configFile = lib.genAttrs (map (file: "opencode/${file}") opencodeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/${target}";
      recursive = true;
    });
}
