{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.gnomeExtensions.burn-my-windows
        pkgs.gnomeExtensions.app-icons-taskbar
        pkgs.gnomeExtensions.espresso
        pkgs.gnomeExtensions.memento-mori
      ];
    };
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
