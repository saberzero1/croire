{ flake, config, pkgs, ... }:
{
  home.file = {
    ".config/wezterm" = {
      source = "${flake.inputs.dotfiles}/wezterm";
      recursive = true;
    };
    ".config/nvim/lua" = {
      source = "${flake.inputs.dotfiles}/lua";
      recursive = true;
    };
    ".config/nvim/init.lua" = {
      source = "${flake.inputs.dotfiles}/init.lua";
    };
    ".config/nvim/lazy-lock.json" = {
      source = "${flake.inputs.dotfiles}/lazy-lock.json";
    };
    ".config/aerospace/aerospace.toml" = {
      source = "${flake.inputs.dotfiles}/aerospace/aerospace.toml";
    };
    ".config/ranger" = {
      source = "${flake.inputs.dotfiles}/ranger";
      recursive = true;
    };
    ".config/espanso/config" = {
      source = "${flake.inputs.espanso}/config";
      recursive = true;
    };
    ".config/espanso/match" = {
      source = "${flake.inputs.espanso}/match";
      recursive = true;
    };
  };
}
