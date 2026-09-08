{ config, harnessPkgs, lib, ... }:
let
  wrappedClaudeCode = harnessPkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ harnessPkgs.claude-code ];
    buildInputs = [ harnessPkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${harnessPkgs.lib.makeBinPath [ harnessPkgs.nodejs harnessPkgs.python314 ]}
    '';
  };
  claudeFiles = [ "settings.json" "statusline.sh" ];
in {
  home.packages = [ wrappedClaudeCode ];
  home.file = lib.genAttrs (map (file: ".claude/${file}") claudeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/claude/${
          lib.removePrefix ".claude/" target
        }";
    });
}
