{ ... }:
let
  brews =
    builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn})) (
      builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
    )
    ++ [
      {
        args = [ "HEAD" ];
        name = "yabai";
      }
    ];
in
{
  homebrew.brews = brews;
}
