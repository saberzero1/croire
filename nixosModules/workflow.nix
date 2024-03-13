{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.ulauncher
        pkgs.freerdp
        pkgs.espanso
        pkgs.appflowy
      ];
    };
    services = {
      espanso = {
        enable = true;
      };
    };
  };
}
