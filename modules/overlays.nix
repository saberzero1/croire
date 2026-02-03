# Dendritic pattern: Overlays module
# Exports overlays for use throughout the configuration
{ inputs, ... }:
{
  flake.overlays.default = import ../overlays/overlay.nix { inherit inputs; };
}
