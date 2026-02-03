# Dendritic pattern: NixOS module that imports the legacy nixos configuration
# This bridges the old module structure with the new dendritic pattern
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.nixosModules.base = self + /lib/modules/nixos;
}
