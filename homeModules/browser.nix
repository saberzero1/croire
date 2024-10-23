{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    programs = {
      chromium = {
        enable = true;
        package = pkgs.overlays.wavebox;
      };
    };
  };
}
