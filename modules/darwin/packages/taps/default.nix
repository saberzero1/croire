{ inputs, ... }:
let
  taps = inputs.self.lib.croire.filesAsNames ./.;
in
{
  homebrew.taps = taps;
}
