# Dendritic pattern: NixOS module registry
# Bridges old module structure with new dendritic pattern
# Collects all nixos modules into flake.nixosModules
{ inputs, lib, ... }:
let
  inherit (inputs) self;

  # Feature modules - unified configurations for NixOS
  # Located in ./_features/ to avoid auto-import by import-tree (paths with /_ are ignored)
  featureModules = {
    system = import ./_features/nixos-system.nix { inherit inputs lib; };
  };
in
{
  # Export all nixos modules
  flake.nixosModules = {
    # Feature modules (dendritic pattern)
    inherit (featureModules.system.flake.nixosModules) system;
  };
}
