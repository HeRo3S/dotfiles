{ lib, buildNpmPackage, fetchurl, fetchNpmDeps, nodejs_22, runCommand, jq }:

buildNpmPackage (finalAttrs: {
  pname = "easy-llm-cli";
  version = "0.1.10";

  src = fetchurl {
    url =
      "https://registry.npmjs.org/easy-llm-cli/-/easy-llm-cli-${finalAttrs.version}.tgz";

    hash = "sha256-lr05lieo1pgeVHqAMbJ+Y+kjQl5bgRLUMnmHYB/+p80=";
  };

  nativeBuildInputs = [ jq ];

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
    # Disable postinstall to avoid running missing git-dependent script
    jq '.scripts.postinstall = ""' package.json > package.json.tmp && mv package.json.tmp package.json
    # If prepare script exists and causes issues, uncomment:
    jq '.scripts.prepare = ""' package.json > package.json.tmp && mv package.json.tmp package.json
  '';

  npmDeps = fetchNpmDeps {
    src = runCommand "qwen-code-src-with-lock" { } ''
      mkdir -p $out
      tar -xzf ${finalAttrs.src} -C $out --strip-components=1
      cp ${./package-lock.json} $out/package-lock.json
    '';
    hash = "sha256-M0VTeMr8akZt9WUvwcSP1tg/guRWvDTnLUZOklffLUE=";
  };

  npmFlags = [ "--ignore-scripts" ];
  dontNpmBuild = true;

  nodejs = nodejs_22;

  meta = {
    description = "Command-line AI workflow tool for Qwen3-Coder models";
    homepage = "github.com/ConardLi/easy-llm-cli";
    license = lib.licenses.asl20;
    # sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    # maintainers = with lib.maintainers; [ zimbatm lonerOrz ];
    platforms = lib.platforms.all;
    mainProgram = "elc";
  };
})
