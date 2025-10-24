{ inputs, ... }:
{
  imports =
    inputs.self.lib.croire.autoImport ./.
    ++ [
      ./home
      ./xdg
    ];
}
