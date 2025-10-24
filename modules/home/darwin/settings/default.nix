{ croire-lib, ... }:
{
  imports =
    croire-lib.autoImport ./.
    ++ [
      ./home
      ./xdg
    ];
}
