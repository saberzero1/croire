{ pkgs, lib, ... }:
{
  home = {
    activation = {
      lazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        echo "Cleaning Neovim plugin cache"
        rm -rf "$HOME/.local/share/nvim/lazy/*"
        rm -rf "$HOME/.cache/nvim/luac/*"
        echo "Cleaning Neovim plugin cache done"
        echo "Installing LazyVim lockfile"
        cp -r "$HOME/Repos/shelter/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
        echo "Installing LazyVim lockfile done"
        echo "Installing Neovim plugins"
        ${pkgs.neovim}/bin/nvim --headless "+Lazy! restore" "+Lazy! clean" "+qa"
        echo "Installing Neovim plugins done"
      '';
    };
  };
}
