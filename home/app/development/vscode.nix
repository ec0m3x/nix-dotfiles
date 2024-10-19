{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "onFocusChange";
      "[nix]"."editor.tabSize" = 2;
      "window.menuBarVisibility" = "toggle";
      "window.density.editorTabHeight" = "default";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "workbench.startupEditor" = "none";
      "git.autofetch" =  true;
      "workbench.colorTheme" = "Atom One Dark";
      "workbench.iconTheme" = "ayu";
    };
  };

  nixpkgs.config = {
  allowUnfree = true;
  allowUnfreePredicate = (_: true);
  };
}
