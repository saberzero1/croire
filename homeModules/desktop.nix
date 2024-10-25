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
        "ulauncher/user-themes/manifest.json" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/ulauncher/manifest.json"; };
        "ulauncher/user-themes/theme.css" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/ulauncher/theme.css"; };
        "ulauncher/user-themes/theme-gtk-3.20.css" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/ulauncher/theme-gtk-3.20.css"; };
      };
    };
    systemd = {
      user = {
        services = {
          ulauncher = {
            Unit = {
              Description = "Linux Application Launcher";
              Documentation = [ "https://ulauncher.io/" ];
            };
            Service = {
              Type = "Simple";
              Restart = "Always";
              RestartSec = 1;
              ExecStart = pkgs.writeShellScript "ulauncher-env-wrapper.sh" ''
                export PATH="''${XDG_BIN_HOME}:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
                export GDK_BACKEND=wayland
                exec ${pkgs.ulauncher}/bin/ulauncher --hide-window
              '';
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
          };
        };
      };
    };
  };
}
