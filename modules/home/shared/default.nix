{ croire-lib, ... }:
{
  imports =
    croire-lib.autoImport ./.
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
