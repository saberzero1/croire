{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    nixpkgs = {
      overlays = [
        (import ../overlays/wavebox.nix)
      ];
    };
    environment = {
      systemPackages = [
        pkgs.wavebox
      ];
    };
  };
}
