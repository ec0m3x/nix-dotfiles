{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [ vim
      vscode
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  #Allow unfree
  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  users.users.ecomex = {
    name = "ecomex";
    home = "/Users/ecomex";
  };

  # Homebrew needs to be installed on its own!
  homebrew.enable = true;
  homebrew.casks = [
    "google-chrome"
  ];
  
  homebrew.brews = [    
  ];
}