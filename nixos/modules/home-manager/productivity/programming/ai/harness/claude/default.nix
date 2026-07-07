{ config, pkgs, lib, inputs, ... }:
let
  wrappedClaudeCode = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs pkgs.python314 ]}
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
