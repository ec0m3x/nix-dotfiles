{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = lib.mkForce "0.7";
      modify_font = "cell_width 90%";
    };
  };

  
}
