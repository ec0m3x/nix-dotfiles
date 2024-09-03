{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    git
    gh 
  ];
 
  programs.gh.enable = true;
  programs.git.enable = true;
  programs.git.userName = "ecomex";
  programs.git.userEmail = "skoch@sks-concept.de";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
}
