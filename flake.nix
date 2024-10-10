{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        rhaenyra = nixpkgs.lib.nixosSystem {
          inherit system;

	  specialArgs = { inherit inputs; };

          modules = [
            ./hosts/rhaenyra

            ./users/mettz
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs system; };
              home-manager.users.mettz.imports = [
                ./users/mettz/dots.nix
              ];
	      home-manager.backupFileExtension = "bak";
            }
          ];
        };
      };
    };
}
