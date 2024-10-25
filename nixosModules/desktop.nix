{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  username = inputs.self.username;
  burnMyWindowsProfile = pkgs.writeText "nix-profile.conf" ''
    [burn-my-windows-profile]

    profile-high-priority=true
    profile-window-type=0
    profile-animation-type=0
    fire-enable-effect=false
    tv-glitch-enable-effect=true
    tv-glitch-animation-time=750
    tv-glitch-scale=1.00
    tv-glitch-strength=2.00
    tv-glitch-speed=2.00
    tv-glitch-color=#64A0FF
  '';
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
    environment = {
      systemPackages = [
        pkgs.gdm
        pkgs.gnome-shell
        pkgs.gnome-shell-extensions
        pkgs.gnome-browser-connector
        pkgs.gnomeExtensions.burn-my-windows
        pkgs.gnomeExtensions.app-icons-taskbar
        pkgs.gnomeExtensions.espresso
        pkgs.gnomeExtensions.memento-mori
        pkgs.gnomeExtensions.paperwm
        pkgs.gnome-remote-desktop
        pkgs.nautilus
        pkgs.nautilus-python
        pkgs.nautilus-open-any-terminal
        pkgs.xrdp
        pkgs.freerdp
      ];
      # Most of these are optional programs added by services.gnome.core-services
      # and etc., but the module sets other useful options so it is better to
      # exclude these instead of disabling the module.
      gnome = {
        excludePackages = [
          pkgs.baobab # disk usage analyzer
          # epiphany # web browser
          pkgs.geary # e-mail client
          pkgs.gnome-backgrounds
          pkgs.gnome-bluetooth
          pkgs.gnome-characters
          pkgs.gnome-clocks
          pkgs.gnome-color-manager
          pkgs.gnome-contacts
          pkgs.gnome-font-viewer
          pkgs.gnome-logs
          pkgs.gnome-music
          pkgs.gnome-system-monitor
          pkgs.gnome-themes-extra
          pkgs.glib
          # pkgs.gnome-connections
          pkgs.gnome-photos
          pkgs.gnome-text-editor
          pkgs.gnome-tour
          pkgs.gnome-user-docs
          pkgs.orca # screen reader
          pkgs.simple-scan
          pkgs.totem # video player
          pkgs.yelp # help viewer
        ];
      };
      sessionVariables = {
        DEFAULT_BROWSER = "${pkgs.wavebox}/bin/wavebox";
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins";
        NIXOS_OZONE_WL = "1";
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERM = "wezterm";
        BROWSER = "${pkgs.wavebox}/bin/wavebox";
        LAZY = "/home/${username}/Documents/lazy-nvim";
      };
    };
    xdg = {
      mime = {
        enable = true;
        defaultApplications = associations;
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
      };
    };
    services = {
      xserver = {
        enable = true;
        desktopManager = {
          gnome = {
            enable = true;
          };
          wallpaper = {
            combineScreens = false;
            mode = "fill";
          };
        };
        displayManager = {
          gdm = {
            enable = true;
          };
        };
      };
      xrdp = {
        enable = true;
        defaultWindowManager = "gnome-remote-desktop";
        openFirewall = true;
        port = 3389;
      };
      gnome = {
        gnome-browser-connector = {
          enable = true;
        };
      };
    };
    programs = {
      dconf = {
        enable = true;
        profiles = {
          user = {
            databases = [{
              settings = with lib.gvariant; {
                "org/gnome/shell".enabled-extensions = [
                  "burn-my-windows@schneegans.github.com"
                  "paperwm@paperwm.github.com"
                ];
                "org/gnome/shell/extensions/burn-my-windows".active-profile = "${burnMyWindowsProfile}";
                "org/gnome/shell/extensions/paperwm/keybindings" = {
                  close-window = ["<Ctr><Alt>q"];
                  # Scratch Layer
                  toggle-scratch = ["<Shift><Ctr><Alt>space"];
                  toggle-scratch-layer = ["<Ctr><Alt>space"];
                  # Windows
                  # Alt Tab
                  live-alt-tab = ["<Ctr><Alt>period"];
                  live-alt-tab-backward = ["<Ctr><Alt>comma"];
                  # Movement
                  move-left = ["<Ctr><Alt>h"];
                  move-down = ["<Ctr><Alt>j"];
                  move-up = ["<Ctr><Alt>k"];
                  move-right = ["<Ctr><Alt>l"];
                  # Switching
                  switch-left = ["<Shift><Ctr><Alt>h"];
                  switch-down = ["<Shift><Ctr><Alt>j"];
                  switch-up = ["<Shift><Ctr><Alt>k"];
                  switch-right = ["<Shift><Ctr><Alt>l"];

                  # Workspaces
                  # Alt Tab
                  previous-workspace = ["<Shift><Ctr><Alt>period"];
                  previous-workspace-backward = ["<Shift><Ctr><Alt>comma"];
                  # Workspace Movement
                  move-down-workspace = ["<Shift><Ctr><Alt>m"];
                  move-up-workspace = ["<Shift><Ctr><Alt>n"];

                  # Monitors
                  # Monitor Movement
                  move-monitor-left = ["<Shift><Ctr><Alt>y"];
                  move-monitor-below = ["<Shift><Ctr><Alt>u"];
                  move-monitor-above = ["<Shift><Ctr><Alt>i"];
                  move-monitor-right = ["<Shift><Ctr><Alt>o"];

                  # Unbinds
                  move-previous-workspace = mkEmptyArray type.string;
                  move-previous-workspace-backward = mkEmptyArray type.string;
                  switch-down-workspace = mkEmptyArray type.string;
                  switch-first = mkEmptyArray type.string;
                  switch-last = mkEmptyArray type.string;
                  switch-monitor-above = mkEmptyArray type.string;
                  switch-monitor-below = mkEmptyArray type.string;
                  switch-monitor-left = mkEmptyArray type.string;
                  switch-monitor-right = mkEmptyArray type.string;
                  switch-next= mkEmptyArray type.string;
                  switch-previous= mkEmptyArray type.string;
                  switch-up-workspace = mkEmptyArray type.string;
                };
              };
            }];
          };
        };
      };
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "wezterm";
      };
    };
    systemd = {
      user = {
        tmpfiles = {
          rules = [
            "L+ %h/.config/burn-my-windows/profiles/nix-profile.conf 0755 - - - ${burnMyWindowsProfile}"
          ];
        };
      };
    };
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
