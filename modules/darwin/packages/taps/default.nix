{ flake, ... }:
let
  taps = flake.inputs.self.lib.croire.filesAsNames ./.;
in
{
  homebrew.taps = taps;
}
