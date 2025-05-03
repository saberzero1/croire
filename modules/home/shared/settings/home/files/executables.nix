{ flake, ... }:
{
  home.file = builtins.listToAttrs (
    builtins.map
      (source: {
        name = ".config/${source}";
        value = {
          source = "${flake.inputs.dotfiles}/${source}";
          executable = true;
        };
      })
      [
        "tmux/scripts/tmux-sessionizer"
        "zsh/scripts/shortcuts"
      ]
  );
}
