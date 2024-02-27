{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.gnugrep
        pkgs.gnused
      ];
    };
  };
}
