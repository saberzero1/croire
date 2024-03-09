{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.ulauncher
      ];
    };
    services = {
      espanso = {
        configs = {
          default = { };
        };
        enable = true;
        matches = {
          matches = [ ];
        };
        ;
        package = pkgs.espanso;
      };
    };
  };
}
