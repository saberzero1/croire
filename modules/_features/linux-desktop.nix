# Dendritic feature module: Linux Desktop configuration
# Provides Linux-specific desktop environment (Hyprland, Wayland, GTK)
# Exports: homeModules.linuxDesktop
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.linuxDesktop =
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
    lib.mkIf isLinux {
      # ─────────────────────────────────────────────────────────────────────────
      # GTK Theme Configuration
      # ─────────────────────────────────────────────────────────────────────────
      gtk = {
        enable = true;
        colorScheme = "dark";
        iconTheme = {
          name = "Dark";
          package = pkgs.tokyonight-gtk-theme;
        };
        theme = {
          name = "storm";
          package = pkgs.tokyonight-gtk-theme;
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Hyprland Window Manager
      # ─────────────────────────────────────────────────────────────────────────
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        # Use null to inherit package from NixOS module (programs.hyprland.package)
        # This avoids version mismatches between system and home-manager
        package = null;
        portalPackage = null;
        systemd = {
          enable = true;
          variables = [ "--all" ];
        };
        settings = {
          monitor = ",preferred,auto,1";

          exec-once = [
            "hyprlock || hyperctl dispatch exit"
            "systemctl --user import-environment"
            "hyprpaper"
            "avizo-service"
            "mako"
            "eval $(ssh-agent -s)"
            "eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
          ];

          env = [
            "XCURSOR_SIZE,24"
            "QT_QPA_PLATFORMTHEME,qt6ct"
            "QT_QPA_PLATFORM,wayland"
          ];

          input = {
            kb_layout = "us";
            follow_mouse = 1;
            touchpad.natural_scroll = false;
            sensitivity = 0;
          };

          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 1;
            "col.active_border" = "rgba(7aa2f7ee)";
            "col.inactive_border" = "rgba(414868aa)";
            layout = "dwindle";
            allow_tearing = false;
          };

          decoration = {
            rounding = 5;
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          master.new_status = "master";
          misc.force_default_wallpaper = 0;

          # Window rules
          windowrule = [
            "workspace 1, match:class ^(ghostty)$"
            "workspace 1, match:class ^(wezterm)$"
            "workspace 2, match:class ^(obsidian)$"
            "workspace 3, match:class ^(zen)$"
            "workspace 4, match:class ^(zed)$"
            "workspace 4, match:class ^(codium-url-handler)$"
            "workspace 4, match:class ^(wine)$"
            "workspace 5, match:class ^(discord)$"
            "float true, match:class ^(com.github.finefindus.eyedropper)$"
          ];

          # Keybindings
          "$mod" = "SUPER_ALT";
          "$mod2" = "SUPER_ALT_CTRL";

          bind = [
            # Applications
            "$mod, t, exec, ghostty"
            "$mod, g, exec, ghostty"
            "$mod, n, exec, obsidian"
            "$mod, w, exec, zen"
            "$mod, z, exec, zed"
            "$mod, d, exec, discord"

            # Window management
            "$mod, q, killactive,"
            "$mod, c, exec, hyprctl reload"
            "$mod, f, fullscreen,"
            "$mod2, space, togglefloating,"

            # Launcher
            "$mod, o, exec, wofi --show drun"
            "$mod2, o, exec, wofi --show drun"

            # Screenshots
            ", Print, exec, grimblast copy area"
            "SHIFT, Print, exec, grimblast save area ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d-%H%M%S.png')"

            # Lock screen
            "SUPER, l, exec, hyprlock"

            # Focus movement
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            # Window movement
            "$mod2, h, movewindow, l"
            "$mod2, l, movewindow, r"
            "$mod2, k, movewindow, u"
            "$mod2, j, movewindow, d"
            "$mod2, left, movewindow, l"
            "$mod2, right, movewindow, r"
            "$mod2, up, movewindow, u"
            "$mod2, down, movewindow, d"

            # Workspace switching
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # Move to workspace
            "$mod2, 1, movetoworkspace, 1"
            "$mod2, 2, movetoworkspace, 2"
            "$mod2, 3, movetoworkspace, 3"
            "$mod2, 4, movetoworkspace, 4"
            "$mod2, 5, movetoworkspace, 5"
            "$mod2, 6, movetoworkspace, 6"
            "$mod2, 7, movetoworkspace, 7"
            "$mod2, 8, movetoworkspace, 8"
            "$mod2, 9, movetoworkspace, 9"
            "$mod2, 0, movetoworkspace, 10"

            # Splitting
            "$mod, minus, layoutmsg, splitv"
            "$mod, backslash, layoutmsg, splith"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          binde = [
            # Media keys
            ", XF86MonBrightnessUp, exec, lightctl up"
            ", XF86MonBrightnessDown, exec, lightctl down"
            ", XF86AudioRaiseVolume, exec, volumectl -u up"
            ", XF86AudioLowerVolume, exec, volumectl -u down"
            ", XF86AudioMute, exec, volumectl toggle-mute"
            ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
          ];
        };

        extraConfig = ''
          # Resize submap
          bind = $mod, r, submap, resize

          submap = resize
          bind = , h, resizeactive, -10 0
          bind = , l, resizeactive, 10 0
          bind = , k, resizeactive, 0 -10
          bind = , j, resizeactive, 0 10
          bind = , left, resizeactive, -10 0
          bind = , right, resizeactive, 10 0
          bind = , up, resizeactive, 0 -10
          bind = , down, resizeactive, 0 10
          bind = , escape, submap, reset
          bind = , return, submap, reset
          submap = reset
        '';
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Hyprland Ecosystem Programs
      # ─────────────────────────────────────────────────────────────────────────
      programs = {
        # Hyprlock - lock screen
        hyprlock = {
          enable = true;
          settings = {
            general = {
              disable_loading_bar = true;
              hide_cursor = true;
              grace = 0;
              no_fade_in = false;
            };
            background = [
              {
                path = "${self}/assets/backgrounds/wallpaper_night.png";
                blur_passes = 3;
                blur_size = 5;
              }
            ];
            input-field = [
              {
                size = "400, 50";
                position = "0, -80";
                monitor = "";
                dots_center = true;
                fade_on_empty = false;
                font_color = "rgb(c0caf5)";
                inner_color = "rgb(24283b)";
                outer_color = "rgb(7aa2f7)";
                outline_thickness = 2;
                placeholder_text = "<i>Password...</i>";
                shadow_passes = 2;
              }
            ];
            label = [
              {
                monitor = "";
                text = "$TIME";
                color = "rgb(c0caf5)";
                font_size = 100;
                font_family = "Monaspace Neon";
                position = "0, 200";
                halign = "center";
                valign = "center";
              }
              {
                monitor = "";
                text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
                color = "rgb(c0caf5)";
                font_size = 25;
                font_family = "Monaspace Neon";
                position = "0, 75";
                halign = "center";
                valign = "center";
              }
            ];
          };
        };

        # Waybar - status bar
        waybar = {
          enable = true;
          systemd.enable = true;
          settings = [
            {
              position = "top";
              height = 38;
              modules-left = [ "hyprland/workspaces" ];
              modules-right = [
                "hyprland/mode"
                "network"
                "pulseaudio"
                "battery"
                "clock#date"
                "memory"
                "cpu"
                "clock"
                "tray"
                "custom/power"
              ];
              "hyprland/workspaces" = {
                disable-scroll = true;
                all-outputs = true;
                format = "{icon}";
                persistent-workspaces = {
                  "1" = [ ];
                  "2" = [ ];
                  "3" = [ ];
                  "4" = [ ];
                  "5" = [ ];
                  "6" = [ ];
                  "7" = [ ];
                  "8" = [ ];
                  "9" = [ ];
                  "10" = [ ];
                };
                format-icons = {
                  "1" = "";
                  "2" = "";
                  "3" = "";
                  "4" = "";
                  "5" = "";
                  "6" = "";
                  "7" = "";
                  "8" = "";
                  "9" = "";
                  "10" = "";
                };
              };
              "clock#date" = {
                format = " {:%A, %d %b}";
              };
              "custom/power" = {
                format = "";
                on-clock = "${self}/programs/waybar/waybar-power.sh";
              };
              "clock" = {
                format = " {:%H:%M}";
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                format-alt = "{:%Y-%m-%d}";
              };
              "battery" = {
                states = {
                  warning = 30;
                  critical = 15;
                };
                format = "{icon} {capacity}%";
                format-charging = " {capacity}%";
                format-plugged = "{capacity}%";
                format-alt = "{time} {icon}";
                format-full = " {capacity}%";
                format-icons = [
                  ""
                  ""
                  ""
                ];
              };
              "network" = {
                format-wifi = "  {essid}";
                format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
                format-linked = "{ifname} (No IP) ";
                format-disconnected = " Disconnected";
                format-alt = "{ifname}: {ipaddr}/{cidr}";
              };
              "pulseaudio" = {
                format = "{icon}  {volume}%";
                format-muted = " Muted";
                format-icons = {
                  headphone = "";
                  hands-free = "";
                  headset = "";
                  phone = "";
                  portable = "";
                  car = "";
                  default = [
                    ""
                    ""
                    ""
                  ];
                };
              };
              "hyprland/mode".format = "<span style=\"italic\">{}</span>";
              "tray".spacing = 10;
              "cpu" = {
                format = " {usage}%";
                tooltip = false;
              };
              "memory".format = " {}%";
            }
          ];
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
            #hyprland-mode, #clock.date, #clock, #battery, #pulseaudio, #network, #cpu, #memory {
              background-color: #24283b;
              padding: 5px 10px;
              margin: 5px 0px;
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
            #battery {
              color: #9ece6a;
            }
            #battery.charging {
              color: #9ece6a;
            }
            #clock.date {
              color: #2ac3de;
              border-radius: 0px;
            }
            #memory {
              color: #7dcfff;
            }
            #cpu {
              color: #7aa2f7;
            }
            #clock {
              color: #bb9af7;
              border-radius: 0px 5px 5px 0px;
              margin-right: 10px;
            }
            #hyprland-mode {
              color: #c0caf5;
            }
            #tray {
              background-color: #24283b;
              border-radius: 5px;
              margin-right: 10px;
              margin-top: 5px;
              margin-bottom: 5px;
              margin-left: 0px;
              padding: 5px 10px;
            }
          '';
        };

        # Wofi - application launcher
        wofi = {
          package = pkgs.wofi;
          enable = true;
          settings = {
            stylesheet = "style.css";
            show = "drun";
            matching = "contains";
            no_actions = true;
            width = "550";
            height = "350";
            always_parse_args = true;
            show_all = true;
            print_command = true;
            layer = "overlay";
            insensitive = true;
            allow_markup = true;
            allow_images = true;
          };
          style = ''
            window {
              margin: 0px;
              border: 2px solid #414868;
              border-radius: 5px;
              background-color: #24283b;
              font-family: monospace;
              font-size: 12px;
            }
            #input {
              margin: 5px;
              border: 1px solid #24283b;
              color: #c0caf5;
              background-color: #24283b;
            }
            #input image {
              color: #c0caf5;
            }
            #inner-box {
              margin: 5px;
              border: none;
              background-color: #24283b;
            }
            #outer-box {
              margin: 5px;
              border: none;
              background-color: #24283b;
            }
            #scroll {
              margin: 0px;
              border: none;
            }
            #text {
              margin: 5px;
              border: none;
              color: #c0caf5;
            }
            #entry:selected {
              background-color: #414868;
              font-weight: normal;
            }
            #text:selected {
              background-color: #414868;
              font-weight: normal;
            }
          '';
        };

        # Fuzzel - alternative launcher
        fuzzel = {
          enable = true;
          package = pkgs.fuzzel;
        };

        # Chromium browser
        chromium = {
          enable = true;
          package = pkgs.chromium;
          commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
          ];
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Hyprland Services
      # ─────────────────────────────────────────────────────────────────────────
      services = {
        # Hypridle - idle daemon
        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "hyprctl dispatch dpms on";
            };
            listener = [
              {
                timeout = 36000; # 600 minutes
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 36030; # 600.5 minutes
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
              {
                timeout = 72000; # 1200 minutes
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };

        # Hyprpaper - wallpaper daemon
        hyprpaper = {
          enable = true;
          settings = {
            preload = [
              "${self}/assets/backgrounds/wallpaper_pixel_neon.png"
            ];
            wallpaper = [
              ",${self}/assets/backgrounds/wallpaper_pixel_neon.png"
            ];
            splash = false;
            ipc = "on";
          };
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Linux Desktop Packages
      # ─────────────────────────────────────────────────────────────────────────
      home.packages =
        with pkgs;
        [
          # Wayland utilities
          ulauncher
          freerdp
          wl-clipboard

          # AppImage support
          gearlever
          appimage-run

          # System utilities
          hdparm
          htop
          imagemagick
          mpv
          pamixer
          pciutils
          usbutils
          lsof

          # CLI tools
          atuin
          gh-dash
          xclicker

          # Backup and Sync
          restic
          rclone

          # Encryption / Yubikey
          age-plugin-yubikey
          sops
          yubikey-touch-detector

          # Python (for scripts)
          python3
          python3Packages.pynvim

          # Lua
          luajit

          # VSCodium
          vscode-extensions.asvetliakov.vscode-neovim
          vscodium.fhs

          # Hyprland ecosystem
          hyprlock
          hypridle
          wf-recorder
          grimblast
          mako
          grim
          slurp
          alacritty
          dmenu
          wofi
          gtk-engine-murrine
          gtk_engines
          gsettings-desktop-schemas
          lxappearance
          kdePackages.dragon
          swappy
          xdg-utils
          uwsm

          # Desktop apps
          evince
          foliate
          pulseaudioFull
          avizo
          libnotify
          fuzzel

          # Gaming / Entertainment
          steam
          discord
        ]
        ++ (with flake.inputs; [
          zen-browser.packages."x86_64-linux".twilight
          nix-alien.packages."x86_64-linux".nix-alien
        ]);
    };
}
