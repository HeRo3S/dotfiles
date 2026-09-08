{ harnessPkgs, ... }:

let
  t3code-unwrapped = harnessPkgs.t3code.passthru.unwrapped.overrideAttrs (finalAttrs: {
    version = "0.0.40";

    src = harnessPkgs.fetchFromGitHub {
      owner = "pingdotgg";
      repo = "t3code";
      tag = "v${finalAttrs.version}";
      hash = "sha256-J8kXpfMfm03/DDAiWXJuANwUNDshhiUn7Lf9tV42Xfw=";
    };

    pnpmDeps = harnessPkgs.fetchPnpmDeps {
      pnpm = harnessPkgs.pnpm_11;
      inherit (finalAttrs)
        pname
        version
        src
        pnpmWorkspaces
        ;
      fetcherVersion = 4;
      hash = "sha256-+UsoURSM4VP+CgF1fWROBEB85EuH+iJJM/xDPFigCKk=";
    };

    nativeBuildInputs = finalAttrs.nativeBuildInputs ++ [ harnessPkgs.pkg-config ];
    buildInputs = (finalAttrs.buildInputs or [ ]) ++ [ harnessPkgs.libsecret ];
  });

  t3code = harnessPkgs.t3code.override {
    inherit t3code-unwrapped;
    enableOpencode = true;
  };
in
{
  home.packages = [ t3code ];
}
