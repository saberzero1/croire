{ ... }:
{
  imports =
    (import ../../../../../../lib/auto-import.nix) ./.
    ++ [
      ./files
    ];
}
