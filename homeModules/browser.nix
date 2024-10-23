{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    programs = {
      chromium = {
        enable = true;
        package = self.pkgs.wavebox;
      };
    };
  };
}
