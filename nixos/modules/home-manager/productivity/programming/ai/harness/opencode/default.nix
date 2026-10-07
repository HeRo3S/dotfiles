{ config, pkgsNightly, lib, ... }:
let
  wrappedOpencode = pkgsNightly.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ pkgsNightly.opencode ];
    buildInputs = [ pkgsNightly.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${pkgsNightly.lib.makeBinPath [ pkgsNightly.nodejs pkgsNightly.python314 ]}
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
