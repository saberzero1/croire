{ ... }:
{
  imports =
    (import ../../../../../lib/auto-import.nix) ./.
    ++ [
      ./home
      ./xdg
    ];
}
