{ config, pkgs, ... }:
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
in {
  home.packages = [ wrappedOpencode ];
  home.file = {
    ".config/opencode/opencode.json".source =
      config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/.config/opencode/opencode.json");
  };
}