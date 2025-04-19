{ pkgs, ... }:
{
  services.espanso = {
    enable = false;
    package = pkgs.espanso-wayland;
    configs = { };
    matches = { };
  };
}
