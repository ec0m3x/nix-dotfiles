{ pkgs, lib, ... }:

{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      opacity = lib.mkForce 0.75;
      padding = {
        x = 10;
        y = 10;
      };
      decorations = "buttonless";
      blur = true;
    };
    font.normal.family = "MesloLGS Nerd Font Mono";
    font.size = 14;
  };
}
