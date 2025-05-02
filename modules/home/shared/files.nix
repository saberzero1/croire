{
  flake,
  ...
}:
let
  debug = false;

  files = [
    "starship/starship.toml"
    "tmux/scripts/directories"
  ];
  folders = [
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
  ];
  executables = [
    "tmux/scripts/tmux-sessionizer"
    "zsh/scripts/shortcuts"
  ];
  miscs = [
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
        source = "${flake.inputs.dotfiles}/assets";
        recursive = true;
      };
    }
  ];

  dotfiles = if debug then builtins.path "$HOME/Repos/shelter" else flake.inputs.dotfiles;

  homeFiles = builtins.listToAttrs (
    builtins.map (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
      };
    }) files
    ++ builtins.map (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
        recursive = true;
      };
    }) folders
    ++ builtins.map (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
        executable = true;
      };
    }) executables
    ++ miscs
  );
in
{
  home.file = homeFiles;
}
