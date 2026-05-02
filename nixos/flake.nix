{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:anomalyco/opencode";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-2505, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs2505 = import nixpkgs-2505 {
        inherit system;
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit inputs pkgs2505;
      };
    in {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit specialArgs;
          modules = [
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        miniPC = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit specialArgs;
          modules = [
            ./hosts/miniPC/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        sanan = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit specialArgs;
          modules = [
            ./hosts/sanan/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
