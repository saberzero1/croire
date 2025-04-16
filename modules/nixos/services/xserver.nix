{ pkgs, lib, ... }:
{

  services.xserver = {
    enable = true;
    desktopManager = {
      gnome = {
        enable = true;
      };
      wallpaper = {
        combineScreens = false;
        mode = "fill";
      };
    };
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
    videoDrivers = [
      # "nvidia"
      "nouveau"
    ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

}
