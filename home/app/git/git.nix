{ config, pkgs, ... }:

{
 
  programs.git = {
    enable = true;
    userName = "ecomex";
    userEmail = "skoch@sks-concept.de";
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
