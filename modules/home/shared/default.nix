{ flake, ... }:
{
  imports =
    flake.inputs.self.lib.croire.autoImport ./.
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
