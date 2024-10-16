{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        # inputs.home-manager.nixosModules.default
        # inputs.home-manager.nixosModules
        # {
        #     home-manager.users.amelia = import ./hosts/home.nix;
        # }
      ];
    };
    homeManagerModules.default = ./hosts/home.nix;
  };
}
