{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.rustup
        pkgs.nixd
        pkgs.nixpkgs-fmt
      ];
    };
  };
}
