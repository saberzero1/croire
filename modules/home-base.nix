# Dendritic pattern: Home Manager module that imports the legacy home configuration
# This bridges the old module structure with the new dendritic pattern
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  # Export both base and platform-specific modules
  flake.homeModules = {
    base = self + /lib/modules/home;
    darwin-only = self + /lib/modules/home/darwin-only.nix;
    linux-only = self + /lib/modules/home/linux-only.nix;
  };
}
