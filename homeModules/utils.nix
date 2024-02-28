{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs._7zz
      ];
    };
    programs = {
      ripgrep = {
        enable = true;
        package = pkgs.ripgrep;
      };
    };
  };
}
