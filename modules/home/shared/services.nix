{ pkgs, ... }:
{
  services = {
    espanso = {
      enable = true;
      package = pkgs.espanso-wayland;
      configs = { };
      matches = { };
    };
  };
}
