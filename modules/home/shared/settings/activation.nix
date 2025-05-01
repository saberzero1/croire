{ lib, ... }:
{
  home = {
    activation = {
      lazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        echo "Installing LazyVim lockfile"
        cp -r "$HOME/Repos/shelter/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
        echo "Installing LazyVim lockfile done"
      '';
    };
  };
}
