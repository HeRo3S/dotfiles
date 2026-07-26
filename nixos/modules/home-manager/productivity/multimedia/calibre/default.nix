{ pkgs, lib, ... }:
let
  calibreWithOpenSSL = pkgs.symlinkJoin {
    name = "calibre-with-openssl";
    paths = [ pkgs.calibre ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/calibre \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pkgs.openssl.out ]}
    '';
  };
in { home.packages = [ calibreWithOpenSSL ]; }
