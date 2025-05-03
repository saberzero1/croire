{ flake, ... }:
{
  home.file = builtins.listToAttrs (
    builtins.map
      (source: {
        name = ".config/${source}";
        value = {
          source = "${flake.inputs.dotfiles}/${source}";
        };
      })
      [
        "starship/starship.toml"
        "tmux/scripts/directories"
      ]
  );
}
