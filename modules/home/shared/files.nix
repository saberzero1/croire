{ flake
, config
, lib
, ...
}:
let
  dotfiles = "${config.home.homeDirectory}/Repos/shelter/";
  symlink =
    symlink:
    if lib.trivial.inPureEvalMode then
      "${flake.inputs.dotfiles}/${symlink}"
    else
      "${dotfiles}/${symlink}";
  # config.lib.file.mkOutOfStoreSymlink dotfiles + symlink;
in
{
  xdg.configFile = {
    "bat/config".enable = false;
    "bat/syntaxes/ghostty.sublime-syntax".enable = false;
    "ranger/rc.conf".enable = false;
    "tmux/tmux.conf".enable = false;
    "wezterm/wezterm.lua".enable = false;
    wezterm = {
      enable = true;
      force = true;
      source = symlink "wezterm";
    };
    nvim = {
      enable = true;
      source = symlink "nvim";
    };
    aerospace = {
      enable = true;
      source = symlink "aerospace";
    };
    ranger = {
      enable = true;
      force = true;
      source = symlink "ranger";
    };
    ghostty = {
      enable = true;
      source = symlink "ghostty";
    };
    rclone = {
      enable = true;
      source = symlink "rclone";
    };
    bat = {
      enable = true;
      source = symlink "bat";
    };
    tmux = {
      enable = true;
      force = true;
      source = symlink "tmux";
    };
    "tmux/scripts/tmux-sessionizer" = {
      enable = true;
      source = symlink "tmux/scripts/tmux-sessionizer";
      executable = true;
    };
    /*
      ".config/yabai" = {
        source = "${flake.inputs.dotfiles}/yabai";
        recursive = true;
      };
    */
    skhd = {
      enable = true;
      source = symlink "skhd";
    };
    espanso = {
      source = "${flake.inputs.totten}";
    };
  };
}
