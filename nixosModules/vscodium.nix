{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.vscodium.fhs
        pkgs.vscode-extensions.asvetliakov.vscode-neovim
      ];
    };
  };
}
