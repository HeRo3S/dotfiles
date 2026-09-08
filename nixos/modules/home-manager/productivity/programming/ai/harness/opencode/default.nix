{ config, harnessPkgs, lib, ... }:
let
  wrappedOpencode = harnessPkgs.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ harnessPkgs.opencode ];
    buildInputs = [ harnessPkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${harnessPkgs.lib.makeBinPath [ harnessPkgs.nodejs harnessPkgs.python314 ]}
    '';
  };
  opencodeFiles = [ "opencode.json" "tui.json" "skills" ];
in {
  imports = [ ./openchamber.nix ];

  home.packages = [ wrappedOpencode ];
  xdg.configFile = lib.genAttrs (map (file: "opencode/${file}") opencodeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/${target}";
      recursive = true;
    });
}
