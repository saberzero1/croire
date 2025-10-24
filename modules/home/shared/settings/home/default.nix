{ flake, ... }:
{
  imports =
    flake.inputs.self.lib.croire.autoImport ./.
    ++ [
      ./files
    ];
}
