{ flake, ... }:
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
    ".config/espanso" = {
      source = "${flake.inputs.totten}";
      recursive = true;
    };
  };
}
