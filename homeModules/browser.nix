{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: 

let
  overlays = [
    (import ../overlays/wavebox.nix)
  ];
in

{
  home.packages = [
    (pkgs.wavebox.override {
      inherit overlays;
    })
  ];
  config = {
    programs = {
      chromium = {
        enable = true;
        package = pkgs.wavebox;
      };
    };
  };
}
