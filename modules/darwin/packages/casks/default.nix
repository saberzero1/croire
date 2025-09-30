{ ... }:
let
  casks =
    builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn})) (
      builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
    )
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
