{ pkgs, ... }:

let
  pname = "openchamber";
  version = "1.22.2";

  src = pkgs.fetchurl {
    url = "https://github.com/openchamber/openchamber/releases/download/v${version}/OpenChamber-${version}-linux-x86_64.AppImage";
    hash = "sha256-CYcctHZTtt5kAcg9d2OE69WJ6LaZX/zWeRdcTnmUn4Q=";
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };

  openchamber = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/openchamber.desktop \
        $out/share/applications/openchamber.desktop
      install -d $out/share/icons/hicolor/512x512/apps
      ${pkgs.imagemagick}/bin/magick \
        ${appimageContents}/usr/share/icons/hicolor/1024x1024/apps/openchamber.png \
        -resize 512x512 \
        $out/share/icons/hicolor/512x512/apps/openchamber.png

      substituteInPlace $out/share/applications/openchamber.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=openchamber'
    '';
  };
in
{
  home.packages = [ openchamber ];
}
