{ flake, ... }:
{
  imports = flake.flake.inputs.self.lib.croire.autoImport ./.;
}
