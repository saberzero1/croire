{ lib, config, ... }:
{
  home.activation = {
    lazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Installing LazyVim"
      cp -r "${config.home.homeDirectory}/Repos/shelter/nvim" "${config.home.homeDirectory}/.config"
      echo "Installing LazyVim done"
    '';
  };
}
