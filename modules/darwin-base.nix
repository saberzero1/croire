# Dendritic pattern: Darwin module registry
# Bridges old module structure with new dendritic pattern
# Collects all darwin modules into flake.darwinModules
{ inputs, lib, ... }:
let
  inherit (inputs) self;

  # Feature modules - unified configurations for Darwin
  # Located in ./_features/ to avoid auto-import by import-tree (paths with /_ are ignored)
  featureModules = {
    system = import ./_features/darwin-system.nix { inherit inputs lib; };
  };
in
{
  # Export all darwin modules
  flake.darwinModules = {
    # Feature modules (dendritic pattern)
    inherit (featureModules.system.flake.darwinModules) system;
  };
}
