{ lib, ... }:
let
  product = lib.lists.foldr (a: b: a * b) 1;
in
{
  home.sessionVariables = {
    HOMEBREW_AUTO_UPDATE_SEC = product [
      60
      60
      24
      7
    ];
  };
}
