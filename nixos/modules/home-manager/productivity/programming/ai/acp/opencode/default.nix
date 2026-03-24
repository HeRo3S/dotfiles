{ config, pkgs, lib, ... }:
let
  wrappedOpencode = pkgs.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ pkgs.opencode ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
    '';
  };
  opencodeFiles = [
    "opencode.json"
    "tui.json"
    "skills/git-commit/SKILL.md"
  ];
in {
  home.packages = [ wrappedOpencode ];
  xdg.configFile = lib.genAttrs
    (map (file: "opencode/${file}") opencodeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/${target}";
    });
}
