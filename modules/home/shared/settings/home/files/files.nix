{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (pkgs.stdenv) isDarwin;
  darwinExtras =
    if isDarwin then
      [
        "zed/keymap.json"
        "zed/settings.json"
      ]
    else
      [ ];
in
{
  home.file = builtins.listToAttrs (
    builtins.map
      (source: {
        name = ".config/${source}";
        value = {
          source = "${self}/programs/${source}";
        };
      })
      (
        [
          "just/justfile"
          "starship/starship.toml"
          "yazi/flavors/tokyo-night.yazi"
          # "tmux/scripts/directories"
        ]
        ++ darwinExtras
      )
  );
}
