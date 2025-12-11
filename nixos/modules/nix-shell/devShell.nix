{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      devShell."x86_64-linux" = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            # add your development environment here
            # https://nixos.wiki/wiki/Flakes#devShell
          ];
      };
    };
}
