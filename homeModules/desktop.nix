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
        "org/gnome/shell" = {
          favorite-apps = ["org.gnome.Nautilus.desktop" "Wavebox.desktop" "obsidian.desktop" "discord.desktop" "codium.desktop"];
        };
      };
    };
    xdg = {
      mime = {
        enable = true;
        defaultApplications = {
          "text/html" = "Wavebox.desktop";
          "x-scheme-handler/http" = "Wavebox.desktop";
          "x-scheme-handler/https" = "Wavebox.desktop";
          "x-scheme-handler/about" = "Wavebox.desktop";
          "x-scheme-handler/unknown" = "Wavebox.desktop";
        };
      };
    };
  };
}
