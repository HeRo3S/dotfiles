{ config, harnessPkgs, inputs, lib, ... }:
let
  opencode = inputs.opencode.packages.${harnessPkgs.stdenv.hostPlatform.system}.opencode;
  wrappedOpencode = harnessPkgs.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ ((opencode.override {
      # Upstream's dependency hash is stale at ffa4c4c (x86_64-linux).
      node_modules = opencode.node_modules.override {
        hash = "sha256-vsKjt9w8IGaoD9o7hkI+pf0i22G6gAzutZHvLHqxIRc=";
      };
    }).overrideAttrs {
      # v2 no longer exposes the completion command used by upstream's install hook.
      postInstall = "";
    }) ];
    buildInputs = [ harnessPkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${harnessPkgs.lib.makeBinPath [ harnessPkgs.nodejs harnessPkgs.python314 ]}
    '';
  };
  opencodeFiles = [ "opencode.json" "cli.json" "skills" ];
in {
  imports = [ ./openchamber.nix ];

  home.packages = [ wrappedOpencode ];
  xdg.configFile = lib.genAttrs (map (file: "opencode/${file}") opencodeFiles)
    (target: {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.customVars.dotfilesDir}/.config/${target}";
      recursive = true;
      # opencode (v2 service/TUI) recreates cli.json on its own, so a
      # plain file always exists here to collide with this symlink.
      force = true;
    });
}
