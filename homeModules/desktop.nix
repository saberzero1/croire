{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: 
let
  browser = [
    # Wavebox doesn't handle external links currently.
    # "Wavebox.desktop"
    "org.gnome.epiphany.desktop"
  ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/appflowy-flutter" = ["appflowy.desktop"];
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
  };
in
{
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
      mimeApps = {
        enable = true;
        defaultApplications = associations;
        associations.added = associations;
        configFile."mimeapps.list".force = true;
      };
    };
  };
}
