{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.wine64Packages.waylandFull
      ];
    };
    programs = {
      waybar = {
        enable = true;
        package = pkgs.waybar;
        settings = [ ];
        style = ''

'';
        systemd = {
          target = "hyprland-session.target";
        };
      };
    };
    wayland = {
      windowManager = {
        hyprland = {
          enable = true;
          package = pkgs.hyprland;
          systemd = {
            enable = true;
          };
          xwayland = {
            enable = true;
          };
        };
      };
    };
  };
}
