{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  system = {
    userActivationScripts = {
      postUserActivation.text = ''
        echo "Cleaning Neovim plugin cache"
        sudo rm -rf "$HOME/.local/share/nvim/lazy"
        sudo rm -rf "$HOME/.cache/nvim/luac/*"
        sudo rm -rf "$HOME/.config/nvim"
        echo "Cleaning Neovim plugin cache done"

        echo "Installing LazyVim"
        sudo mkdir -p "$HOME/.config/nvim"
        cp -r "${self}/programs/nvim" "$HOME/.config"
        echo "Installing LazyVim done"

        echo "Setting tmux-sessionizer permissions"
      '';
    };
  };
}
