{ pkgs, ... }:

{ 
  home.packages = with pkgs; [
    brave
  ];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  };
}
