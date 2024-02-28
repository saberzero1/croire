{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.vscodium
        pkgs.vscode-extensions.asvetliakov.vscode-neovim
      ];
    };
  };
}
