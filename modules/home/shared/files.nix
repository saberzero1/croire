{ config, pkgs, ... }:
{
  home.file = {
    "config/wezterm" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/wezterm";
      recursive = true;
    };
    "config/nvim/lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lua";
      recursive = true;
    };
    "config/nvim/init.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/init.lua";
    };
    "config/nvim/lazy-lock.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/lazy-lock.json";
    };
    "config/starship/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
      #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
    };
    #"config/zsh/.zshrc" = {
    #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/scripts/.zshrc";
    #};
    "config/starship.toml" = {
      source = "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
    };
    "config/aerospace/aerospace.toml" = {
      source = "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/aerospace/aerospace.toml";
    };
  };
}
