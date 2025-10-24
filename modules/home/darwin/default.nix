{ ... }:
{
  imports =
    (import ../../../lib/auto-import.nix) ./.
    ++ [
      ./programs
      ./services
      ./settings
    ];
}
