{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    dconf = {
      settings = with lib.hm.gvariant; {
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///home/saberzero1/Documents/Repos/dotfiles/croire/assets/wallpaper.png";
          picture-uri-dark = "file:///home/saberzero1/Documents/Repos/dotfiles/croire/assets/wallpaper.png";
        };
      };
    };
  };
}
