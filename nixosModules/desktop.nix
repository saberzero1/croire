{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: 
let
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
    environment = {
      systemPackages = [
        pkgs.gnome.gdm
        pkgs.gnome.gnome-shell
        pkgs.gnome.gnome-shell-extensions
        pkgs.gnome-browser-connector
        pkgs.gnomeExtensions.burn-my-windows
        pkgs.gnomeExtensions.app-icons-taskbar
        pkgs.gnomeExtensions.espresso
        pkgs.gnomeExtensions.memento-mori
        pkgs.gnome.gnome-remote-desktop
        pkgs.xrdp
        pkgs.freerdp
      ];
      # Most of these are optional programs added by services.gnome.core-services
      # and etc., but the module sets other useful options so it is better to
      # exclude these instead of disabling the module.
      gnome = {
        excludePackages = with pkgs.gnome; [
          baobab # disk usage analyzer
          # epiphany # web browser
          geary # e-mail client
          gnome-backgrounds
          gnome-bluetooth
          gnome-characters
          gnome-clocks
          gnome-color-manager
          gnome-contacts
          gnome-font-viewer
          gnome-logs
          gnome-music
          gnome-system-monitor
          gnome-themes-extra
          pkgs.glib
          # pkgs.gnome-connections
          pkgs.gnome-photos
          pkgs.gnome-text-editor
          pkgs.gnome-tour
          pkgs.gnome-user-docs
          pkgs.orca # screen reader
          simple-scan
          totem # video player
          yelp # help viewer
        ];
      };
      sessionVariables = {
        DEFAULT_BROWSER = "${pkgs.wavebox}/bin/wavebox";
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins";
        NIXOS_OZONE_WL = "1";
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
              settings = {
                "org/gnome/shell".enabled-extensions = [
                  "burn-my-windows@schneegans.github.com"
                ];
                "org/gnome/shell/extensions/burn-my-windows".active-profile = "${burnMyWindowsProfile}";
              };
            }];
          };
        };
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
