{ config, lib, pkgs, ... }:

let
  homeDirectory = "/Users/emile";
in
{
  "wezterm/colors.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/colors.lua"; };
  "wezterm/font.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/font.lua"; };
  "wezterm/keybinds.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/keybinds.lua"; };
  "wezterm/mousebinds.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/mousebinds.lua"; };
  "wezterm/wezterm.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm/wezterm.lua"; };
  "nvim/init.lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua"; };
  "nvim/lazy-lock.json" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json"; };
  # "nvim/.stylua.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/.stylua.toml"; };
  "nvim/neovim.yml" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/neovim.yml"; };
  "nvim/lua" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua"; };
  "ranger/commands.py" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/commands.py"; };
  "ranger/commands_full.py" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/commands_full.py"; };
  "ranger/rc.conf" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/rc.conf"; };
  "ranger/rifle.conf" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/rifle.conf"; };
  "ranger/scope.sh" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/scope.sh"; };
  "ranger/plugins/ranger_devicons/__init__.py" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/plugins/ranger_devicons/__init__.py"; };
  "ranger/plugins/ranger_devicons/devicons.py" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/ext/ranger/plugins/ranger_devicons/devicons.py"; };
  "starship/starship.toml" = { source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml"; };
}