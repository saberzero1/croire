{ ... }:
{
  imports =
    (import ../../../lib/auto-import.nix) ./.
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
