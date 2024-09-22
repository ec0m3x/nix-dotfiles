{ config, pkgs, lib, ... }:

{
  imports =
    [ ../../home/shell/sh.nix
      ../../home/app/git/git.nix
      ../../home/app/terminal/wezterm/wezterm.nix
      ../../home/app/terminal/alacritty/alacritty.nix
      ../../home/app/terminal/starship/starship.nix
      #../../home/app/terminal/cava.nix
      ../../home/shell/darwin-cli-collection.nix
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    obsidian
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
