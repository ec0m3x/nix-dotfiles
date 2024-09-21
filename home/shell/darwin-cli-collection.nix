{ pkgs, ... }:
{
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    disfetch 
    lolcat 
    cowsay
    neofetch
    killall
    timer
    bat eza fd bottom ripgrep sl
    tree
    rsync
    unzip
    btop
    htop
    vim neovim
    ranger
    curl
    less
  ];
}