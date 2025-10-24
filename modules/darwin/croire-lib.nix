# Provides croire-lib to all Darwin modules
{ flake, ... }:
{
  _module.args.croire-lib = flake.lib.croire;
}
