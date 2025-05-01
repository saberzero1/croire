{ flake
, ...
}:
let
  dotfiles = flake.inputs.dotfiles;
  file =
    { source }:
    {
      ".config/${source}" = {
        source = "${dotfiles}/${source}";
      };
    };
  folder =
    { source
    , recursive ? false
    ,
    }:
    {
      ".config/${source}" = {
        source = "${dotfiles}/${source}";
        recursive = recursive;
      };
    };
  executable =
    { source }:
    {
      ".config/${source}" = {
        source = "${dotfiles}/${source}";
        executable = true;
      };
    };
  fileSources = [
    "starship/starship.toml"
    "scripts/tmux/directories"
    "skhd"
  ];
  folderSources = [
    "wezterm"
    "nvim"
    "aerospace"
    "ranger"
    "ghostty"
    "rclone"
    "bat"
    "scripts/tmux/directories"
    "skhd"
  ];
  executableSources = [
    "scripts/tmux/tmux-sessionizer"
    "scripts/zsh/shortcuts"
  ];
in
{
  home.file = {
    ".config/wezterm" = {
      source = "${flake.inputs.dotfiles}/wezterm";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${flake.inputs.dotfiles}/nvim";
      recursive = true;
    };
    ".config/starship/starship.toml" = {
      source = "${flake.inputs.dotfiles}/starship/starship.toml";
    };
    ".config/aerospace" = {
      source = "${flake.inputs.dotfiles}/aerospace";
      recursive = true;
    };
    ".config/ranger" = {
      source = "${flake.inputs.dotfiles}/ranger";
      recursive = true;
    };
    ".config/ghostty" = {
      source = "${flake.inputs.dotfiles}/ghostty";
      recursive = true;
    };
    ".config/rclone" = {
      source = "${flake.inputs.dotfiles}/rclone";
      recursive = true;
    };
    ".config/bat" = {
      source = "${flake.inputs.dotfiles}/bat";
      recursive = true;
    };
    /*
      ".config/tmux" = {
        source = "${flake.inputs.dotfiles}/tmux";
        recursive = true;
      };
    */
    ".config/scripts/tmux/tmux-sessionizer" = {
      source = "${flake.inputs.dotfiles}/tmux/scripts/tmux-sessionizer";
      executable = true;
    };
    ".config/scripts/tmux/directories" = {
      source = "${flake.inputs.dotfiles}/tmux/scripts/directories";
    };
    ".config/scripts/zsh/shortcuts" = {
      source = "${flake.inputs.dotfiles}/zsh/scripts/shortcuts";
      executable = true;
    };
    /*
      ".config/yabai" = {
        source = "${flake.inputs.dotfiles}/yabai";
        recursive = true;
      };
    */
    ".config/skhd" = {
      source = "${flake.inputs.dotfiles}/skhd";
      recursive = true;
    };
    ".config/espanso" = {
      source = "${flake.inputs.totten}";
      recursive = true;
    };
    ".assets/backgrounds" = {
      source = "${flake.inputs.dotfiles}/assets";
      recursive = true;
    };
  };
}
