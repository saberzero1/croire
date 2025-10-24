{ inputs, ... }:
{
  imports =
    inputs.self.lib.croire.autoImport ./.
    ++ [
      ./programs
      ./services
      ./settings
    ];
}
