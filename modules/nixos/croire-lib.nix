# Provides croire-lib to all NixOS modules
{ flake, ... }:
{
  _module.args.croire-lib = flake.lib.croire;
}
