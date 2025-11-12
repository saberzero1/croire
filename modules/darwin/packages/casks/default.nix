{ flake, ... }:
let
  casks = flake.inputs.self.lib.croire.filesAsStrings ./.;
in
{
  homebrew.casks = casks;
}
