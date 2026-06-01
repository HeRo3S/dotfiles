{ inputs, config, ... }: {
  imports = [ inputs.agenix.nixosModules.default ];

  age = {
    secrets.steamAPI = {
      file = ./secrets/steamAPI.age;
      owner = config.customCfg.user.name;
      mode = "0400";
    };
    identityPaths =
      [ "/home/${config.customCfg.user.name}/.ssh/github_personal" ];
  };
}
