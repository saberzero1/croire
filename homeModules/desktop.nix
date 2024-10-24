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
    home = {
      packages = [
        #inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        inputs.hyprland.nixosModules.default
        pkgs.kitty
      ];
    };
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
    programs = {
      kitty = {
        enable = true;
      };
      # hyprland = {
      #   # Install the packages from nixpkgs
      #   enable = true;
      #   # set the flake package
      #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #   # make sure to also set the portal package, so that they are in sync
      #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      #   # Whether to enable XWayland
      #   xwayland.enable = true;
      # };
    };
    wayland = {
      windowManager = {
        hyprland = {
          enable = true;
          #plugins = {};
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
        "hypr" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/hyprland"; };
      };
    };
  };
}
