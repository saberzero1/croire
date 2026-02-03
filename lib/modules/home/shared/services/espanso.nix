{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isLinux;
in
{
  services = {
    espanso = {
      # On macOS, espanso is installed via Homebrew to maintain stable accessibility permissions.
      # Nix-installed binaries have changing hashes that cause macOS to revoke permissions on rebuild.
      # See: https://github.com/nix-community/home-manager/issues/8179
      enable = isLinux;
      package = pkgs.espanso;
      package-wayland = pkgs.espanso-wayland;
      waylandSupport = isLinux;
      x11Support = isLinux;
    };
  };
}
