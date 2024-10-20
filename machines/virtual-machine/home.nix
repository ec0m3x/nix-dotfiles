{ config, pkgs, pkgs-stable, inputs, userSettings, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/shell/cli-collection.nix
      ../../home/app/git/git.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/"+userSettings.username;

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Core
    zsh
    git


    # Media
    ffmpeg
    movit
    mediainfo
    libmediainfo

    # Fonts
    nerdfonts
    font-awesome
  ];

  news.display = "silent";

  # Let Home Manager install and manage itself.

  nix.gc.automatic = true;
  nix.gc.frequency = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  programs.home-manager.enable = true;
}
