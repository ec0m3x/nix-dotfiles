{ config, pkgs, pkgs-stable, inputs, userSettings, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      #../../home/wm/hyprland/hyprland.nix
      #../../home/hardware/bluetooth.nix
      ../../home/shell/cli-collection.nix
      #../../home/style/stylix.nix
      ../../home/app/git/git.nix
      #../../home/app/development/vscode.nix
      #../../home/app/flatpak/flatpak.nix
      #../../home/app/cloud/nextcloud-client.nix
      #../../home/app/games/games.nix
      #../../home/app/virtualisation/virtualisation.nix
      #(./. + "../../../home/app/browser"+("/"+userSettings.browser)+".nix")
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
