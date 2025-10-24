{ ... }:
let
  brews = (import ../../../../lib/files-as-names.nix) ./.;
in
{
  homebrew.brews = brews;
}
