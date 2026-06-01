{ inputs, config, ... }: {
  imports = [ inputs.agenix.nixosModules.default ];

  age = {
    secrets = { steamAPI.file = ./secrets/steamAPI.age; };
    identityPaths =
      [ "/home/${config.customCfg.user.name}/.ssh/github_personal" ];
  };
}
