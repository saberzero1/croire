{ flake
, lib
, ...
}:
let
  dotfiles = "$HOME/Repos/shelter/";
  symlink =
    symlink:
    if lib.trivial.inPureEvalMode then
      "${flake.inputs.dotfiles}/" + symlink
    else
      lib.file.mkOutOfStoreSymlink dotfiles + symlink;
in
{
  home.file = {
    ".config/wezterm" = {
      source = symlink "wezterm";
      recursive = true;
    };
    ".config/nvim" = {
      source = symlink "nvim";
      recursive = true;
    };
    ".config/aerospace" = {
      source = symlink "aerospace";
      recursive = true;
    };
    ".config/ranger" = {
      source = symlink "ranger";
      recursive = true;
    };
    ".config/ghostty" = {
      source = symlink "ghostty";
      recursive = true;
    };
    ".config/rclone" = {
      source = symlink "rclone";
      recursive = true;
    };
    ".config/bat" = {
      source = symlink "bat";
      recursive = true;
    };
    ".config/tmux" = {
      source = symlink "tmux";
      recursive = true;
    };
    /*
      ".config/yabai" = {
        source = "${flake.inputs.dotfiles}/yabai";
        recursive = true;
      };
    */
    ".config/skhd" = {
      source = symlink "skhd";
      recursive = true;
    };
    ".config/espanso" = {
      source = "${flake.inputs.totten}";
      recursive = true;
    };
  };
}
