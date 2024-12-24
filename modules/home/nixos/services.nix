{ pkgs, ... }:
{
  services = {
    mako = {
      enable = true;
    };

    wlsunset = {
      enable = true;
      package = pkgs.wlsunset;
      sunrise = "08:00";
      sunset = "18:00";
      temperature = {
        day = 6500;
        night = 4000;
      };
    };

    espanso = {
      enable = true;
      package = pkgs.espanso-wayland;
      configs = { };
      matches = { };
    };
  };
}
