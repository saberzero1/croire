{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.rustup
        pkgs.nixd
        pkgs.nixpkgs-fmt
        pkgs.nixfmt-rfc-style
      ];
    };
  };
}
