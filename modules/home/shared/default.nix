{ inputs, ... }:
{
  imports =
    inputs.self.lib.croire.autoImport ./.
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
