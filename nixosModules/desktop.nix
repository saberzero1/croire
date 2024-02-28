{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.hyprland
        pkgs.waybar
        pkgs.wine64Packages.waylandFull
      ];
    };
  };
}
