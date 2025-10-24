{ croire-lib, ... }:
{
  imports =
    croire-lib.autoImport ./.
    ++ [
      ./files
    ];
}
