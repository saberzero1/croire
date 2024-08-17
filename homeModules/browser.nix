{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    nixpkgs = {
      overlays = [
        (import ../overlays/wavebox.nix)
      ];
    };
    programs = {
      chromium = {
        enable = true;
        package = pkgs.wavebox;
      };
    };
  };
}
