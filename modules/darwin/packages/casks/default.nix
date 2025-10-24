{ ... }:
let
  casks =
    (import ../../../../lib/files-as-names.nix) ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
