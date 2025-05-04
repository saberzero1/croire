{ flake, ... }:
{
  home.file = builtins.listToAttrs (
    (builtins.map
      (source: {
        name = ".config/${source}";
        value = {
          source = "${flake.inputs.dotfiles}/${source}";
          recursive = true;
        };
      })
      [
        "wezterm"
        "nvim"
        "aerospace"
        "ranger"
        "ghostty"
        "rclone"
        "bat"
        # "skhd"
        # "yabai"
        # "tmux"
      ]
    )
    ++ [
      {
        name = ".config/espanso";
        value = {
          source = "${flake.inputs.totten}";
          recursive = true;
        };
      }
      {
        name = ".assets/backgrounds";
        value = {
          source = "${flake.inputs.dotfiles}/assets/backgrounds";
          recursive = true;
        };
      }
    ]
  );
}
