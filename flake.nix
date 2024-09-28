{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: 
    let
    in
    {
      nixosConfigurations = {
        rhaenyra = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix  
          ];
        };
      };
    };
}
