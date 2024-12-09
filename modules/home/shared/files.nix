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
    ".config/ranger/commands.py" = { source = "${flake.inputs.dotfiles}/ranger/commands.py"; };
    ".config/ranger/commands_full.py" = { source = "${flake.inputs.dotfiles}/ranger/commands_full.py"; };
    ".config/ranger/rc.conf" = { source = "${flake.inputs.dotfiles}/ranger/rc.conf"; };
    ".config/ranger/rifle.conf" = { source = "${flake.inputs.dotfiles}/ranger/rifle.conf"; };
    ".config/ranger/scope.sh" = { source = "${flake.inputs.dotfiles}/ranger/scope.sh"; };
    ".config/ranger/plugins/ranger_devicons/__init__.py" = { source = "${flake.inputs.dotfiles}/ranger/plugins/ranger_devicons/__init__.py"; };
    ".config/ranger/plugins/ranger_devicons/devicons.py" = { source = "${flake.inputs.dotfiles}/ranger/plugins/ranger_devicons/devicons.py"; };
  };
}
