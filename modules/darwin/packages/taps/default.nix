{ ... }:
let
  taps = (import ../../../../lib/files-as-names.nix) ./.;
in
{
  homebrew.taps = taps;
}
