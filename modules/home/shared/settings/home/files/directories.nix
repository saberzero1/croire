{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  home.file = builtins.listToAttrs (
    (builtins.map
      (source: {
        name = ".config/${source}";
        value = {
          source = "${self}/programs/${source}";
          recursive = true;
        };
      })
      [
        "wezterm"
        # "nvim"
        "aerospace"
        "ranger"
        "ghostty"
        "rclone"
        "bat"
        "skhd"
        # "sketchybar"
        "yabai"
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
          source = "${self}/assets/backgrounds";
          recursive = true;
        };
      }
    ]
  );
}
