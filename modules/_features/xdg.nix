# Dendritic feature module: XDG configuration
# Provides XDG Base Directory specification settings and desktop entries
# Exports: homeModules.xdg
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.xdg =
    {
      pkgs,
      config,
      lib,
      flake,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    {
      # ─────────────────────────────────────────────────────────────────────────
      # XDG Base Directory Configuration (Cross-platform)
      # ─────────────────────────────────────────────────────────────────────────
      xdg = {
        enable = true;

        # Standard XDG directories
        cacheHome = "${config.home.homeDirectory}/.cache";
        configHome = "${config.home.homeDirectory}/.config";
        dataHome = "${config.home.homeDirectory}/.local/share";
        stateHome = "${config.home.homeDirectory}/.local/state";

        # ───────────────────────────────────────────────────────────────────────
        # Linux-only: MIME Apps and Desktop Entries
        # ───────────────────────────────────────────────────────────────────────
        mimeApps = lib.mkIf isLinux {
          enable = true;
          defaultApplications = {
            "text/html" = [ "zen.desktop" ];
            "x-scheme-handler/http" = [ "zen.desktop" ];
            "x-scheme-handler/https" = [ "zen.desktop" ];
            "x-scheme-handler/ftp" = [ "zen.desktop" ];
            "x-scheme-handler/chrome" = [ "zen.desktop" ];
            "x-scheme-handler/about" = [ "zen.desktop" ];
            "x-scheme-handler/unknown" = [ "zen.desktop" ];
            "application/x-extension-htm" = [ "zen.desktop" ];
            "application/x-extension-html" = [ "zen.desktop" ];
            "application/x-extension-shtml" = [ "zen.desktop" ];
            "application/xhtml+xml" = [ "zen.desktop" ];
            "application/x-extension-xhtml" = [ "zen.desktop" ];
            "application/x-extension-xht" = [ "zen.desktop" ];
          };
          associations.added = {
            "text/html" = [ "zen.desktop" ];
            "x-scheme-handler/http" = [ "zen.desktop" ];
            "x-scheme-handler/https" = [ "zen.desktop" ];
            "x-scheme-handler/ftp" = [ "zen.desktop" ];
            "x-scheme-handler/chrome" = [ "zen.desktop" ];
            "x-scheme-handler/about" = [ "zen.desktop" ];
            "x-scheme-handler/unknown" = [ "zen.desktop" ];
            "application/x-extension-htm" = [ "zen.desktop" ];
            "application/x-extension-html" = [ "zen.desktop" ];
            "application/x-extension-shtml" = [ "zen.desktop" ];
            "application/xhtml+xml" = [ "zen.desktop" ];
            "application/x-extension-xhtml" = [ "zen.desktop" ];
            "application/x-extension-xht" = [ "zen.desktop" ];
          };
        };

        # ───────────────────────────────────────────────────────────────────────
        # Linux-only: Desktop Entries
        # ───────────────────────────────────────────────────────────────────────
        desktopEntries = lib.mkIf isLinux {
          "nvim" = {
            name = "Neovim";
            comment = "Edit text files";
            icon = "nvim";
            exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim}/bin/nvim %F";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "ranger" = {
            name = "Ranger";
            comment = "TUI File Explorer";
            icon = "${self}/assets/icons/ssd.png";
            exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "geforce-now-appimage" = {
            name = "GeForce NOW (AppImage)";
            comment = "Cloud Gaming";
            icon = "${config.home.homeDirectory}/AppImages/.icons/geforce_now.png";
            exec = "${pkgs.bash}/bin/bash -c ${config.home.homeDirectory}/AppImages/geforce_now";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "geforce-now-offloaded" = {
            name = "GeForce NOW (Offloaded)";
            comment = "Cloud Gaming";
            icon = "${config.home.homeDirectory}/AppImages/.icons/geforce_now.png";
            exec = "nvidia-offload com.nvidia.geforcenow";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "geforce-now-infinity-offloaded" = {
            name = "GeForce NOW Infinity (Offloaded)";
            comment = "Cloud Gaming";
            icon = "${config.home.homeDirectory}/AppImages/.icons/geforce_now.png";
            exec = "gamescoperun -x \"-W 2560 -H 1440\" geforce-infinity";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "obsidian" = {
            name = "Obsidian";
            comment = "Knowledge Management";
            icon = "${self}/assets/icons/obsidian.png";
            exec = "${pkgs.obsidian}/bin/obsidian %U";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
          "shutdown" = {
            name = "Shutdown";
            comment = "Shutdown the system";
            icon = "${self}/assets/icons/shutdown.png";
            exec = "${pkgs.wezterm}/bin/wezterm -e shutdown --poweroff --no-wall 0";
            categories = [ "System" ];
            terminal = false;
          };
          "reboot" = {
            name = "Reboot";
            comment = "Reboot the system";
            icon = "${self}/assets/icons/restart.png";
            exec = "${pkgs.wezterm}/bin/wezterm -e reboot";
            categories = [ "System" ];
            terminal = false;
          };
          "tmux-sessionizer" = {
            name = "Tmux Sessionizer";
            comment = "Tmux Sessionizer";
            icon = "${self}/assets/icons/tmux.png";
            exec = "${pkgs.wezterm}/bin/wezterm -e ${config.home.homeDirectory}/.config/tmux/scripts/tmux-sessionizer";
            categories = [ "Application" ];
            terminal = false;
            mimeType = [ "text/plain" ];
          };
        };
      };
    };
}
