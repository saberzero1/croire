{ flake
, ...
}:
let
  files = [
    "starship/starship.toml"
    "scripts/tmux/directories"
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

  dotfiles = flake.inputs.dotfiles;

  fileSources = builtins.map
    (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
      };
    })
    files;
  folderSources = builtins.map
    (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
        recursive = true;
      };
    })
    folders;
  executableSources = builtins.map
    (source: {
      name = ".config/${source}";
      value = {
        source = "${dotfiles}/${source}";
        executable = true;
      };
    })
    executables;
  miscSources = miscs;
in
{
  home.file = builtins.listToAttrs (fileSources ++ folderSources ++ executableSources ++ miscSources);
}
