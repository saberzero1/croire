# Home: emile (Darwin)
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
    username = "emile";
    homeDirectory = "/Users/emile";
    stateVersion = "25.11";
  };

  # Import home-manager modules via config.flake (available via extraSpecialArgs)
  # The base module and program modules are imported through the systems.nix helper
}
