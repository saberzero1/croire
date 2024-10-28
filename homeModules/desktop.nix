{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  browser = [
    "wavebox.desktop"
  ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
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
          favorite-apps = [
            "ranger.desktop"
            "wavebox.desktop"
            "obsidian.desktop"
            "discord.desktop"
            "nvim.desktop"
          ];
        };
      };
    };
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = associations;
        associations.added = associations;
      };
      configFile = {
        "mimeapps.list".force = true;
        "paperwm/user.css" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/paperwm/user.css"; };
        "paperwm/user.js" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/paperwm/user.js"; };
        "sway/config" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/sway/config"; };
      };
    };
    programs = {
      wofi = {
        enable = true;
        package = pkgs.wofi;
        settings = {
          MODE = "drun";
          insensitive = true;
          gtd_dark = true;
        };
        # style = ''
        #   ...
        # '';
      };
    };
  };
}
