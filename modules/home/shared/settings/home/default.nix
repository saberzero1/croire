{ inputs, ... }:
{
  imports =
    inputs.self.lib.croire.autoImport ./.
    ++ [
      ./files
    ];
}
