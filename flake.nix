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
      systemSettings = {
        system = "x86_64-linux";
        machine = "desktop";
      };
      
      lib = inputs.nixpkgs.lib;

      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
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
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          (./. + "/machines" + ("/" + systemSettings.machine) + "/configuration.nix")
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          (./. + "/machines" + ("/" + systemSettings.machine) + "/home.nix")
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
