{
  description = "My NixOS";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ... }@inputs:
  let
      # --- System Settings --- #
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      home-manager = inputs.home-manager;

      # --- User Settings --- #
      userSettings = rec {
        username = "ecomex"; # Your username;
        name = "Sebastian"; # Your name;
        email = "skoch@sks-concept.de"; # Your email;
        browser = "firefox"; # Default browser command;
        term = "alacritty"; # Default terminal command;
        theme = "horizon-dark"; # Default theme;
        font = "Intel One Mono"; # Default font;
        fontPkg = pkgs.intel-one-mono; # Default font package;
      };

  in {

    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./machines/desktop/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit userSettings;
        };
      };
      nixos-server = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./machines/homeserver/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      ecomex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./machines/desktop/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit userSettings;
        };
      };
    };
  };
}
