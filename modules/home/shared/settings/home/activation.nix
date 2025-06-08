{ flake
, lib
, config
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  home.activation = {
    lazyVim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Installing LazyVim"
      rm -rf "${config.home.homeDirectory}/.config/nvim"
      cp -r "${self}/programs/nvim" "${config.home.homeDirectory}/.config/nvim"
      echo "Installing LazyVim done"
    '';
  };
}
