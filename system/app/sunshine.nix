{ pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    autoStart = true;
  }
}