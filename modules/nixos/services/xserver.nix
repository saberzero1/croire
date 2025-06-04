{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    desktopManager = {
      wallpaper = {
        combineScreens = false;
        mode = "fill";
      };
    };
    displayManager = {
      sessionCommands = ''
        ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      '';
    };
    videoDrivers = [
      "nvidia"
    ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
