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
          executable = true;
        };
      })
      [
        "tmux/scripts/tmux-sessionizer"
        "zsh/scripts/shortcuts"
      ]
  );
}
