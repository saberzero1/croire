{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.hyprland
        pkgs.waybar
      ];
    };
  };
}
