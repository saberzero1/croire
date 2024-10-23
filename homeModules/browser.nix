{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    programs = {
      chromium = {
        enable = true;
        package = pkgs.wavebox;
      };
    };
  };
}
