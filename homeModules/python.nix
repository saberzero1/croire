{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.python3
        pkgs.python311Packages.black
      ];
    };
  };
}
