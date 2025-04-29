{ pkgs, ... }:
{
  system = {
    activationScripts = {
      postActivation.text = ''
        echo "Setting tmux-sessionizer permissions"

        echo "Cleaning Neovim plugin cache"
        rm -rf "$HOME/.local/share/nvim/lazy/*"
        rm -rf "$HOME/.cache/nvim/luac/*"
        echo "Cleaning Neovim plugin cache done"
        echo "Installing Neovim plugins"
        ${pkgs.neovim}/bin/nvim --headless "+Lazy! restore" "+Lazy! clean" "+qa" 2>/dev/null
        echo "Installing Neovim plugins done"
      '';
    };
  };
}
