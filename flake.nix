{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      agenix,
      ...
    }:
    let
      systemSettings = {
        system = "x86_64-linux";
      };
      userSettings = {
        name = "Mattia Guazzaloca";
        email = "mattia.guazzaloca@gmail.com";
        username = "mettz";
        shell = "fish";
      };
    in
    {
      nixosConfigurations = {
        rhaenyra = nixpkgs.lib.nixosSystem {
          inherit (systemSettings) system;

          specialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };

          modules = [
            ./hosts/rhaenyra
            agenix.nixosModules.default
            ./user
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit systemSettings;
                inherit userSettings;
              };
              home-manager.backupFileExtension = "bak";
              home-manager.users.${userSettings.username}.imports = [
                agenix.homeManagerModules.default
                ./user/home
              ];
            }
          ];
        };
      };
    };
}
