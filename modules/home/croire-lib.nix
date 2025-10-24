# Provides croire-lib to all Home Manager modules
{ flake, ... }:
{
  _module.args.croire-lib = flake.lib.croire;
}
