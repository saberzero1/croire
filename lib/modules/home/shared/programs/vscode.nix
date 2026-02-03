{ pkgs, ... }:
{
  programs.vscode = {
    enable = false;
    profiles = {
      default = {
        enableExtensionUpdateCheck = true;
      };
    };
    mutableExtensionsDir = true;
    package = pkgs.vscodium.fhs;
  };
}
