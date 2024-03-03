{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    services = {
      xserver = {
        desktopManager = {
          gnome = {
            enable = true;
          };
          wallpaper = {
            combineScreens = false;
            mode = "fill";
          };
        };
      };
    };
  };
}
