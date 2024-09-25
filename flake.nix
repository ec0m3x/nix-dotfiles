{
  description = "My NixOS";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nix-darwin, nixpkgs, home-manager, ... }@inputs:
  let
      # --- System Settings --- #
      systemSettings = {
        system = "x86_64-linux";
        machine = "macbook"; #choose desktop, macbook or homeserver
        bootMode = "uefi"; # uefi or bios
        bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode

      };
      
      lib = (if ((systemSettings.machine == "homeserver"))
        then
          inputs.nixpkgs-stable.lib
        else
          inputs.nixpkgs.lib);

      pkgs = (if ((systemSettings.machine == "homeserver"))
              then
                pkgs-stable
              else
                pkgs-unstable);

      pkgs-unstable = import inputs.nixpkgs {
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

      home-manager = (if ((systemSettings.machine == "homeserver"))
             then
               inputs.home-manager-stable
             else
               inputs.home-manager);

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
        system = systemSettings.system;
        modules = [
          ./machines/desktop/configuration.nix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ecomex = import ./machines/desktop/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
      nixos-vm = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./machines/virtual-machine/configuration.nix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ecomex = import ./machines/virtual-machine/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
	      home-manager.extraSpecialArgs = {
		inherit inputs;
		inherit pkgs-stable;
		inherit systemSettings;
		inherit userSettings;
	      };
            }
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
    darwinConfigurations."MacBook" = nix-darwin.lib.darwinSystem {
      modules = [ 
	      (./. + "/machines" + ("/" + systemSettings.machine) + "/configuration.nix")
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ecomex = import (./. + "/machines" + ("/" + systemSettings.machine) + "/home.nix");

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        } 
      ];
      specialArgs = {
        inherit self;
        inherit inputs;
        inherit pkgs-stable;
        inherit systemSettings;
        inherit userSettings;
      };
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."MacBook".pkgs;
  };
}
