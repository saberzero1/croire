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
        pkgs.albert
        pkgs.wofi
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
        DL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = 1;
        MOZ_ENABLE_WAYLAND = 1;
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
          #plasma5 = {
          #  enable = true;
          #};
          wallpaper = {
            combineScreens = false;
            mode = "fill";
          };
        };
        displayManager = {
          gdm = {
            enable = true;
            wayland = true;
          };
          sessionCommands = ''
            ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
          '';
        };
        videoDrivers = [
          # "nvidia"
          "nouveau"
        ];
        # xkb = {
        #   layout = "us";
        # };
      };
      displayManager = {
        defaultSession = "sway";
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
        gnome-keyring = {
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
                  #"paperwm@paperwm.github.com"
                  #"gnome-shell-extension-stealmyfocus@v-dimitrov.github.com"
                ];
                "org/gnome/shell/extensions/burn-my-windows".active-profile = "${burnMyWindowsProfile}";
                # "org/gnome/shell/extensions/paperwm/keybindings" = {
                #   # Assuming keyboard halfleft side:
                #   # Right button: <Super><Alt>
                #   # Left button: <Super><Alt><Ctrl>

                #   # Application operations
                #   new-window = ["<Super><Alt>n"];
                #   close-window = ["<Super><Alt>q"];

                #   # Window width
                #   resize-w-inc = ["<Super><Alt>plus" "<Super><Alt>="]; # Increment width
                #   resize-w-dec = ["<Super><Alt>minus"]; # Decrement width
                #   # Window height
                #   resize-h-inc = ["<Super><Alt><Ctrl>plus"]; # Increment height
                #   resize-h-dec = ["<Super><Alt><Ctrl>minus"]; # Decrement height

                #   # Window dimensions
                #   toggle-maximiza-width = ["<Super><Alt>f"]; # full width
                #   paper-toggle-fullscreen = ["<Super><Alt><Ctrl>f"]; # full screen

                #   # Grab and move windows
                #   take-window = ["<Super><Alt>y"]; # Grab a window
                #   open-window-position-right = ["<Super><Alt>p"]; # Open or drop a grabbed window

                #   # Center window
                #   center = ["<Super><Alt>c"];
                #   switch-focus-mode = ["<Super><Alt><Ctrl>c"];
                #   center-horizontally = mkEmptyArray type.string;
                #   center-vertically = mkEmptyArray type.string;

                #   # Scratch Layer
                #   toggle-scratch = ["<Super><Alt>space"];
                #   toggle-scratch-layer = ["<Super><Alt><Ctrl>space"];

                #   # Windows
                #   # Alt Tab
                #   live-alt-tab = ["<Super><Alt>period"];
                #   live-alt-tab-backward = ["<Super><Alt>comma"];
                #   # Moving Focus
                #   switch-left-loop = ["<Super><Alt>h"];
                #   switch-right-loop = ["<Super><Alt>l"];

                #   switch-down-loop = mkEmptyArray type.string;
                #   switch-up-loop = mkEmptyArray type.string;
                #   switch-left = mkEmptyArray type.string;
                #   switch-right = mkEmptyArray type.string;
                #   switch-down = mkEmptyArray type.string;
                #   switch-up = mkEmptyArray type.string;

                #   # Workspace Moving Focus
                #   switch-down-workspace = ["<Super><Alt>j"];
                #   switch-up-workspace = ["<Super><Alt>k"];
                #   # Moving Position
                #   move-left-loop = ["<Super><Alt><Ctrl>h"];
                #   move-right-loop = ["<Super><Alt><Ctrl>l"];

                #   move-down-loop = mkEmptyArray type.string;
                #   move-up-loop = mkEmptyArray type.string;
                #   move-left = mkEmptyArray type.string;
                #   move-right = mkEmptyArray type.string;
                #   move-down = mkEmptyArray type.string;
                #   move-up = mkEmptyArray type.string;

                #   # Workspace Moving Position
                #   move-down-workspace = ["<Super><Alt><Ctrl>j"];
                #   move-up-workspace = ["<Super><Alt><Ctrl>k"];

                #   # Workspaces
                #   # Alt Tab
                #   previous-workspace = ["<Super><Alt><Ctrl>period"];
                #   previous-workspace-backward = ["<Super><Alt><Ctrl>comma"];

                #   # Monitors
                #   # Monitor Movement
                #   move-monitor-left = ["<Super><Alt><Ctrl>y"];
                #   move-monitor-below = ["<Super><Alt><Ctrl>u"];
                #   move-monitor-above = ["<Super><Alt><Ctrl>i"];
                #   move-monitor-right = ["<Super><Alt><Ctrl>o"];

                #   # Index based movement
                #   switch-first = ["<Super><Alt>1"];
                #   switch-second = ["<Super><Alt>2"];
                #   switch-third = ["<Super><Alt>3"];
                #   switch-fourth = ["<Super><Alt>4"];
                #   switch-fifth = ["<Super><Alt>5"];
                #   switch-sixth = ["<Super><Alt>6"];
                #   switch-seventh = ["<Super><Alt>7"];
                #   switch-eighth = ["<Super><Alt>8"];
                #   switch-ninth = ["<Super><Alt>9"];
                #   switch-last = ["<Super><Alt>0"];

                #   # Unbinds
                #   move-previous-workspace = mkEmptyArray type.string;
                #   move-previous-workspace-backward = mkEmptyArray type.string;
                #   switch-monitor-above = mkEmptyArray type.string;
                #   switch-monitor-below = mkEmptyArray type.string;
                #   switch-monitor-left = mkEmptyArray type.string;
                #   switch-monitor-right = mkEmptyArray type.string;
                #   switch-next = mkEmptyArray type.string;
                #   switch-previous= mkEmptyArray type.string;
                # };
                # "org/gnome/shell/extensions/paperwm/workspace" = {
                #   directory = "";
                # };
              };
            }];
          };
        };
      };
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "wezterm";
      };
      sway = {
        enable = true;
        wrapperFeatures = {
          gtk = true;
        };
        extraPackages = with pkgs; [
          swaylock
          swayidle
          wl-clipboard
          wf-recorder
          mako # notification daemon
          grim
        #kanshi
          slurp
          alacritty # Alacritty is the default terminal in the config
          dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
          # https://gist.github.com/kborling/76805ade81ac5bfdd712df294208c878
          wofi
          gtk-engine-murrine
          gtk_engines
          gsettings-desktop-schemas
          lxappearance
        ];
        #extraSessionCommands = ''
        #  eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh);
        #  export SSH_AUTH_SOCK;
        #'';
      };
      waybar = {
        enable = true;
        settings = {
          position =  "bottom";
          height = 30;
          modules-left = [ "sway/workspaces" ];
          modules-right = [
            "network"
            "pulseaudio"
            "battery"
            "custom/date"
            "clock"
            "custom/power"
          ];
          # Modules configuration
          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            persistent_workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
              "6" = [];
              "7" = [];
              "8" = [];
              "9" = [];
              "10" = [];
            };
            format-icons = {
              "1" = "󰋜";
              "2" = "󰖟";
              "3" = "󰠮";
              "4" = "󰭹";
              "5" = "󱓷";
              "6" = "󱇧";
              "7" = "󰊢";
              "8" = "󰖲";
              "9" = "󰕧";
              "10" = "󰝚";
            };
          };
          "custom/date" = {
            format = "󰸗 {}";
            interval = 3600;
            exec = "$HOME/Documents/Repos/dotfiles-submodules/croire/configFiles/waybar/waybar-date.sh";
          };
          "custom/power" = {
            format = "󰐥";
            on-clock = "$HOME/Documents/Repos/dotfiles-submodules/croire/configFiles/waybar/waybar-power.sh";
          };
          "clock" = {
            format = "󰅐 {:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󰂄{capacity}%";
            format-alt = "{time} {icon}";
            format-full = "󱈑 {capacity}%";
            format-icons = ["󱊡", "󱊢", "󱊣"];
          };
          "network" = {
            format-wifi = "  {essid}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "󰤮 Disconnected";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          "pulseaudio": {
            format = "{icon}  {volume}%";
            format-muted = "󰖁 Muted";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["", "", ""];
            };
          };
        };
        style = ''
* {
border: none;
border-radius: 0;
font-family: mononoki Nerd Font;
font-size: 14px;
min-height: 0;
}

window#waybar {
background: transparent;
color: white;
}

#workspaces {
background-color: #24283b;
margin: 5px;
margin-left: 10px;
border-radius: 5px;
}
#workspaces button {
padding: 5px 10px;
color: #c0caf5;
}

#workspaces button.focused {
color: #24283b;
background-color: #7aa2f7;
border-radius: 5px;
}

#workspaces button:hover {
background-color: #7dcfff;
color: #24283b;
border-radius: 5px;
}

#custom-date, #clock, #battery, #pulseaudio, #network {
background-color: #24283b;
padding: 5px 10px;
margin: 5px 0px;
}

#custom-date {
color: #7dcfff;
}

#custom-power {
color: #24283b;
background-color: #db4b4b;
border-radius: 5px;
margin-right: 10px;
margin-top: 5px;
margin-bottom: 5px;
margin-left: 0px;
padding: 5px 10px;
}

#clock {
color: #b48ead;
border-radius: 0px 5px 5px 0px;
margin-right: 10px;
}

#battery {
color: #9ece6a;
}

#battery.charging {
color: #9ece6a;
}

#battery.warning:not(.charging) {
background-color: #f7768e;
color: #24283b;
border-radius: 5px 5px 5px 5px;
}

#network {
color: #f7768e;
border-radius: 5px 0px 0px 5px;
}

#pulseaudio {
color: #e0af68;
}
        '';
      };
      # wofi = {
      #   enable = true;
      #   settings = {
      #     MODE = "drun";
      #     insensitive = true;
      #     gtd_dark = true;
      #   };
        # style = ''
        #   ...
        # '';
      # };
      # swaylock = {
      #   enable = true;
      # };
      #qt5ct = {
      #  enable = true;
      #};
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
