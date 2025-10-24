{ croire-lib, ... }:
let
  taps = croire-lib.filesAsNames ./.;
in
{
  homebrew.taps = taps;
}
