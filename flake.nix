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
    nixCats.url = "github:BirdeeHub/nixCats-nvim?dir=nix";
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
    };
    homeConfigurations = {
      sinnucso = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  inputs.plasma-manager.homeManagerModules.plasma-manager
          ./hosts/pc-nix/home.nix
	  #./modules/user/kde/kde.nix
	  #./modules/user/kde/konsole.nix
        ];
      };
    };
  };
}
