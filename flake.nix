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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
     mysecrets = {
      url = "git+ssh://git@gitlab.com/Sinnucso/nixos-secrets.git?shallow=1?ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, sops-nix, ... }:
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
	specialArgs = {inherit inputs;};
        modules = [
          ./hosts/lenovo-nix/configuration.nix
	  sops-nix.nixosModules.sops
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
