{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      pc-nix = nixpkgs.lib.nixosSystem {
	inherit system;   #i dont need this?
        modules = [
          ./hosts/pc-nix/configuration.nix
        ];
      };
      acer-nix = nixpkgs.lib.nixosSystem {
	inherit system;   #i dont need this?
        modules = [
          ./hosts/acer-nix/configuration.nix
        ];
      };
      lenovo-nix = nixpkgs.lib.nixosSystem {
	inherit system;   #i dont need this?
        modules = [
          ./hosts/lenovo-nix/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      "sinnucso@pc-nix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  inputs.plasma-manager.homeManagerModules.plasma-manager
	  ./hosts/pc-nix/home.nix
        ];
      };
      "sinnucso@acer-nix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  inputs.plasma-manager.homeManagerModules.plasma-manager
	  ./hosts/acer-nix/home.nix
        ];
      };
      "sinnucso@lenovo-nix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  inputs.plasma-manager.homeManagerModules.plasma-manager
	  ./hosts/lenovo-nix/home.nix
        ];
      };
    };
  };
}
