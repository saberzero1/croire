{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isLinux;
in
{
  services = {
    espanso = {
      enable = true;
      package = pkgs.espanso;
      package-wayland = pkgs.espanso-wayland;
      waylandSupport = isLinux;
      x11Support = isLinux;
    };
  };
}
