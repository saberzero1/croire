{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.enlightenment.enlightenment
        pkgs.enlightenment.econnman
        pkgs.enlightenment.efl
        pkgs.enlightenment.evisum
      ];
    };
    services = {
      xserver = {
        desktopManager = {
          enlightenment = {
            enable = true;
          };
          wallpaper = {
            combineScreens = false;
          };
        };
      };
    };
  };
}
