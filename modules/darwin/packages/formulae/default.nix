{ flake, ... }:
let
  brews = flake.inputs.self.lib.croire.filesAsNames ./.;
in
{
  homebrew.brews = brews;
}
