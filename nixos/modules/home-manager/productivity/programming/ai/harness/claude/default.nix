{
  config,
  pkgsNightly,
  lib,
  ...
}:
let
  wrappedClaudeCode = pkgsNightly.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ pkgsNightly.claude-code ];
    buildInputs = [ pkgsNightly.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${
          pkgsNightly.lib.makeBinPath [
            pkgsNightly.nodejs
            pkgsNightly.python314
          ]
        }
    '';
  };
  claudeFiles = [
    "settings.json"
    "statusline.sh"
  ];
in
{
  home.packages = [ wrappedClaudeCode ];
  home.file = lib.genAttrs (map (file: ".claude/${file}") claudeFiles) (target: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.customVars.dotfilesDir}/.config/claude/${lib.removePrefix ".claude/" target}";
  });
}
