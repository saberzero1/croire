{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.nodePackages_latest.nodejs
        pkgs.luajit
        pkgs.python312Packages.pip
      ];
    };
  };
}
