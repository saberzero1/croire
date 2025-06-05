{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
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
      [
        "just/justfile"
        "starship/starship.toml"
        "tmux/scripts/directories"
      ]
  );
}
