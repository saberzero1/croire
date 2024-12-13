{ flake, pkgs, lib, ... }:
{
  home = {
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
    sessionPath = [
      "/snap/bin"
    ];
  };
  dconf = {
    settings = {
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
      defaultApplications = {
        "text/html" = [ "wavebox.desktop" ];
        "x-scheme-handler/http" = [ "wavebox.desktop" ];
        "x-scheme-handler/https" = [ "wavebox.desktop" ];
        "x-scheme-handler/ftp" = [ "wavebox.desktop" ];
        "x-scheme-handler/chrome" = [ "wavebox.desktop" ];
        "x-scheme-handler/about" = [ "wavebox.desktop" ];
        "x-scheme-handler/unknown" = [ "wavebox.desktop" ];
        "application/x-extension-htm" = [ "wavebox.desktop" ];
        "application/x-extension-html" = [ "wavebox.desktop" ];
        "application/x-extension-shtml" = [ "wavebox.desktop" ];
        "application/xhtml+xml" = [ "wavebox.desktop" ];
        "application/x-extension-xhtml" = [ "wavebox.desktop" ];
        "application/x-extension-xht" = [ "wavebox.desktop" ];
      };
      associations.added = {
        "text/html" = [ "wavebox.desktop" ];
        "x-scheme-handler/http" = [ "wavebox.desktop" ];
        "x-scheme-handler/https" = [ "wavebox.desktop" ];
        "x-scheme-handler/ftp" = [ "wavebox.desktop" ];
        "x-scheme-handler/chrome" = [ "wavebox.desktop" ];
        "x-scheme-handler/about" = [ "wavebox.desktop" ];
        "x-scheme-handler/unknown" = [ "wavebox.desktop" ];
        "application/x-extension-htm" = [ "wavebox.desktop" ];
        "application/x-extension-html" = [ "wavebox.desktop" ];
        "application/x-extension-shtml" = [ "wavebox.desktop" ];
        "application/xhtml+xml" = [ "wavebox.desktop" ];
        "application/x-extension-xhtml" = [ "wavebox.desktop" ];
        "application/x-extension-xht" = [ "wavebox.desktop" ];
      };
    };
    configFile = {
      "mimeapps.list".force = true;
      "paperwm/user.css" = { source = "${flake.inputs.dotfiles}/paperwm/user.css"; };
      "paperwm/user.js" = { source = "${flake.inputs.dotfiles}/paperwm/user.js"; };
      "sway/config" = { source = "${flake.inputs.dotfiles}/sway/config"; };
      "sway-interactive-screenshot/config.toml" = { source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/config.toml"; };
      "sway-interactive-screenshot/sway-interactive-screenshot" = { source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/sway-interactive-screenshot"; };
    };
    desktopEntries = {
      "nvim" = {
        name = "nvim";
        comment = "Edit text files";
        icon = "nvim";
        exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim}/bin/nvim %F";
        categories = [ "Application" ];
        terminal = false;
        mimeType = [ "text/plain" ];
      };
      "explorer" = {
        name = "explorer";
        comment = "TUI File Explorer";
        icon = "ranger";
        exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
        categories = [ "Application" ];
        terminal = false;
        #mimeType = [ "text/plain" ];
      };
    };
  };
}
