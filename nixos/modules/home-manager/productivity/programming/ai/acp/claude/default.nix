{ config, pkgs, lib, ... }:
let
  wrappedClaudeCode = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ pkgs.claude-code ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
    '';
  };
  claudeFiles = [
    "settings.json"
    "statusline.sh"
  ];
in {
  home.packages = [ wrappedClaudeCode ];
  home.file = lib.genAttrs
    (map (file: ".claude/${file}") claudeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/claude/${lib.removePrefix ".claude/" target}";
    });
}
