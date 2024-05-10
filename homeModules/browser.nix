{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: 

let
  overlays = [
    (import ../overlays/wavebox.nix)
  ];
in

{
  config = {
    home = [
      packages = [
        (pkgs.wavebox.override {
          inherit overlays;
        })
      ];
    ];
    programs = {
      chromium = {
        enable = true;
        package = pkgs.wavebox;
      };
    };
  };
}
