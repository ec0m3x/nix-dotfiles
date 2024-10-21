{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    git
    gh 
  ];
 
  programs.git = {
    enable = true;
    userName = "ecomex";
    userEmail = "skoch@sks-concept.de";
    extraConfig = {
      credential.helper = "oauth";
    };
  };
}
