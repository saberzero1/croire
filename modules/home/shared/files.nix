{ flake, config, pkgs, ... }:
{
  home.file = {
    "config/wezterm" = {
      source = "${flake.inputs.dotfiles}/wezterm";
      recursive = true;
    };
    "config/nvim/lua" = {
      source = "${flake.inputs.dotfiles}/lua";
      recursive = true;
    };
    "config/nvim/init.lua" = {
      source = "${flake.inputs.dotfiles}/init.lua";
    };
    "config/nvim/lazy-lock.json" = {
      source = "${flake.inputs.dotfiles}/lazy-lock.json";
    };
    #"config/starship/starship.toml" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
      #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/starship/starship.toml";
      #};
    #"config/zsh/.zshrc" = {
    #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/shelter/scripts/.zshrc";
    #};
    "config/starship.toml" = {
      source = "${flake.inputs.dotfiles}/starship/starship.toml";
    };
    "config/aerospace/aerospace.toml" = {
      source = "${flake.inputs.dotfiles}/aerospace/aerospace.toml";
    };
  };
}
