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
        "tmux/tmux-sessionizer.conf"
        "tmux/scripts/tmux-sessionizer"
        "tmux/scripts/session-template"
        "zsh/scripts/shortcuts"
      ]
  );
}
