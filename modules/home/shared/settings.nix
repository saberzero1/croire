{ pkgs, lib, ... }:
{
  home = {
    activation = {
      lazyVim = lib.hm.dagEntryAfter [ "writeBoundary" ] ''
        echo "Cleaning Neovim plugin cache"
        rm -rf "$HOME/.local/share/nvim/lazy/*"
        rm -rf "$HOME/.cache/nvim/luac/*"
        echo "Cleaning Neovim plugin cache done"
        echo "Installing Neovim plugins"
        sudo chmod +w "$HOME/.config/nvim/lazy-lock.json"
        sudo ${pkgs.neovim}/bin/nvim --headless "+Lazy! restore" "+Lazy! clean" "+qa"
        sudo chmod -w "$HOME/.config/nvim/lazy-lock.json"
        echo "Installing Neovim plugins done"
      '';
    };
  };
}
