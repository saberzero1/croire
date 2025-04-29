{ ... }:
{
  system = {
    activationScripts = {
      postActivation.text = ''
        echo "Cleaning Neovim plugin cache"
        sudo rm -rf "$HOME/.local/share/nvim/lazy"
        sudo rm -rf "$HOME/.cache/nvim/luac/*"
        echo "Cleaning Neovim plugin cache done"

        echo "Setting tmux-sessionizer permissions"
      '';
    };
  };
}
