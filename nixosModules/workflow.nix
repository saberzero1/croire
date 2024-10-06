{ inputs, ... }@flakeContext:
{ config, lib, pkgs, fetchzip, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.ulauncher
        pkgs.freerdp
        pkgs.espanso
      ];
    };
    services = {
      espanso = {
        enable = false;
        package = pkgs.espanso;
      };
    };
  };
}
