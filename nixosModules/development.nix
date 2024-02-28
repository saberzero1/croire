{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.nixosModules.neovim
    inputs.self.nixosModules.vscodium
  ];
}
