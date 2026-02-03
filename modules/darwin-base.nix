# Dendritic pattern: Darwin module that imports the legacy darwin configuration
# This bridges the old module structure with the new dendritic pattern
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.darwinModules.base = self + /lib/modules/darwin;
}
