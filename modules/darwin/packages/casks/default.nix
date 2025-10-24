{ croire-lib, ... }:
let
  casks =
    croire-lib.filesAsNames ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
