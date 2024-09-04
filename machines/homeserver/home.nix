{ config, pkgs, pkgs-stable, inputs, userSettings, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/shell/cli-collection.nix
      ../../home/app/git/git.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ecomex";
  home.homeDirectory = "/home/ecomex";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    git
  ];
  news.display = "silent";

  # Let Home Manager install and manage itself.

  nix.gc.automatic = true;
  nix.gc.frequency = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  programs.home-manager.enable = true;
}
