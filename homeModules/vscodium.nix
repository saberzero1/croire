{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vscode-extensions.asvetliakov.vscode-neovim
        pkgs.vscodium
      ];
    };
    programs = {
      vscode = {
        enable = false;
        enableExtensionUpdateCheck = true;
        mutableExtensionsDir = true;
        package = pkgs.vscodium;
      };
    };
  };
}
