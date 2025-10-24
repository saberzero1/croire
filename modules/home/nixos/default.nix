{ croire-lib, ... }:
{
  imports =
    croire-lib.autoImport ./.
    ++ [
      ./programs
      ./services
      ./settings
      ./../../../scripts/rclone.nix
    ];
}
