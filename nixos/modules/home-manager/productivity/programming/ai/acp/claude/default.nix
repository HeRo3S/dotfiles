{ config, pkgs, lib, ... }:
let
  claudeCodePinned = pkgs.claude-code.overrideAttrs (_old: let
    version = "2.1.52";
    lockfile = "${pkgs.path}/pkgs/by-name/cl/claude-code/package-lock.json";
    src = pkgs.fetchzip {
      url =
        "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-z2KnyIcVabboBFJCTPHICheQHq1rjh/LZ2Y1MQGHTA0=";
    };
    npmDepsHash = "sha256-sk1RdPMgZD+Ejd6JdKWcK24AdfasnwWATQkwAx5MjmY=";
  in {
    inherit version src npmDepsHash;

    npmDeps = pkgs.fetchNpmDeps {
      inherit src;
      hash = npmDepsHash;
      postPatch = ''
        cp ${lockfile} package-lock.json
      '';
    };

    postPatch = ''
      cp ${lockfile} package-lock.json

      substituteInPlace cli.js \
        --replace-fail '#!/bin/sh' '#!/usr/bin/env sh'
    '';
  });

  wrappedClaudeCode = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ claudeCodePinned ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}
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
