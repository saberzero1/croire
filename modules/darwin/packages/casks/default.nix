{ inputs, ... }:
let
  casks =
    inputs.self.lib.croire.filesAsNames ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
