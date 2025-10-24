{ flake, ... }:
{
  imports = [
    ./shared
  ];

  # Make library functions available to all child modules
  _module.args.croire-lib = flake.lib.croire;
}
