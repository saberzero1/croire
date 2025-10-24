{ croire-lib, ... }:
let
  brews = croire-lib.filesAsNames ./.;
in
{
  homebrew.brews = brews;
}
