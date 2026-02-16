# Home: saberzero1 (NixOS)
# Dendritic pattern: Standalone home-manager configuration
{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    username = "saberzero1";
    homeDirectory = "/home/saberzero1";
    stateVersion = "26.05";
  };

  # Import home-manager modules via config.flake (available via extraSpecialArgs)
  # The base module and program modules are imported through the systems.nix helper
}
