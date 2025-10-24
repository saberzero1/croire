{ inputs, ... }:
let
  brews = inputs.self.lib.croire.filesAsNames ./.;
in
{
  homebrew.brews = brews;
}
