{ lib, config, ... }:
{
  home.activation = {
    lazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Installing LazyVim lockfile"
      cp -r "${config.home.homeDirectory}/Repos/shelter/lazy-lock.json" "${config.home.homeDirectory}/.config/nvim/lazy-lock.json"
      echo "Installing LazyVim lockfile done"
    '';
  };
}
