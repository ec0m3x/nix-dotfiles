{ config, pkgs, ... }:

let
  myAliases = {
    ll = "eza --icons=auto --color=always -la";
    ls = "eza --icons=auto --color=always ";
    ".." =  "cd ..";
    reload-zsh = "source ~/.zshrc";
    nixos-full-rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/ && home-manager switch --flake ~/dotfiles/";
    nixos-full-clean = "sudo nix-collect-garbage --delete-old && nix-collect-garbage --delete-old";
    darwin-rebuild-full = "cd ~/.dotfiles/ && darwin-rebuild switch --flake .#MacBook";
  };
in

{
  programs = {
    zsh = {
      enable = true;
      shellAliases = myAliases;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      history.size = 100000;
/*       oh-my-zsh = {
        enable = true;
        plugins = [ "extract" "git" "sudo" ];
        theme = "fino";
      }; */
    };
    bash = {
      enable = true;
      shellAliases = myAliases;
    };
    bat.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza.enable = true;
  };
}
