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
      inherit (flake) inputs;
      tokyonightGtk = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "storm" ];
        iconVariants = [ "Dark" ];
      };
    in
    lib.mkIf isLinux {
      # ─────────────────────────────────────────────────────────────────────────
      # GTK Theme Configuration
      # ─────────────────────────────────────────────────────────────────────────
      gtk = {
        enable = true;
        colorScheme = "dark";
        iconTheme = {
          name = "Tokyonight-Dark";
          package = tokyonightGtk;
        };
        theme = {
          name = "Tokyonight-Dark-Storm";
          package = tokyonightGtk;
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # dconf Settings (GNOME integration)
      # ─────────────────────────────────────────────────────────────────────────
      dconf.settings = {
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file://${config.home.homeDirectory}/.assets/backgrounds/wallpaper.png";
          picture-uri-dark = "file://${config.home.homeDirectory}/.assets/backgrounds/wallpaper.png";
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "ranger.desktop"
            "zen.desktop"
            "obsidian.desktop"
            "discord.desktop"
            "nvim.desktop"
          ];
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Monitor Configuration (for play.nix)
      # ─────────────────────────────────────────────────────────────────────────
      monitors = [
        {
          name = "eDP-1";
          primary = true;
          width = 2560;
          height = 1440;
          refreshRate = 165;
          hdr = false;
          vrr = false;
        }
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Gaming Configuration (play.nix)
      # ─────────────────────────────────────────────────────────────────────────
      play = {
        gamescoperun = {
          enable = true;
          # Use stable nixpkgs gamescope instead of mix-nix git version
          # mix-nix's gamescope-git is broken: nixpkgs shaders-path.patch
          # doesn't apply to the latest git source (GetUsrDir moved files)
          useGit = false;
          defaultHDR = false;
          defaultWSI = true;
          defaultSystemd = false;
          baseOptions = {
            "output-width" = 2560;
            "output-height" = 1440;
          };
          environment = {
            __NV_PRIME_RENDER_OFFLOAD = "1";
            __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            __VK_LAYER_NV_optimus = "NVIDIA_only";
          };
        };
        wrappers = {
          steam-gamescope = {
            enable = true;
            command = "${lib.getExe pkgs.steam} -bigpicture -tenfoot";
            useHDR = false;
            useSystemd = true;
            extraOptions = {
              "steam" = true;
              "fsr-upscaling" = true;
            };
            environment = {
              STEAM_FORCE_DESKTOPUI_SCALING = 1;
              STEAM_GAMEPADUI = 1;
              __NV_PRIME_RENDER_OFFLOAD = 1;
              __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
              __GLX_VENDOR_LIBRARY_NAME = "nvidia";
              __VK_LAYER_NV_optimus = "NVIDIA_only";
            };
          };
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Hyprland Window Manager
      # ─────────────────────────────────────────────────────────────────────────
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        xwayland.enable = true;
        # Use null to inherit package from NixOS module (programs.hyprland.package)
        # This avoids version mismatches between system and home-manager
        package = null;
        portalPackage = null;
        # Disable Home Manager's systemd integration - UWSM handles this
        # (programs.hyprland.withUWSM = true in nixos-system.nix)
        systemd.enable = false;
        # Most config goes through extraConfig with correct Lua API syntax.
        # HM's settings renderer generates hl.<name>() calls that don't always
        # match Hyprland's actual Lua API (e.g. hl.animations() doesn't exist).
        # Keep config blocks in settings (they map to hl.config()), move
        # everything else to extraConfig.
        settings = {
          config = {
            input = {
              kb_layout = "us";
              follow_mouse = 1;
              sensitivity = 0;
              touchpad = {
                natural_scroll = false;
              };
            };
            general = {
              gaps_in = 5;
              gaps_out = 10;
              border_size = 1;
              col = {
                active_border = "rgba(7aa2f7ee)";
                inactive_border = "rgba(414868aa)";
              };
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
            };
            dwindle = {
              preserve_split = true;
            };
            master = {
              new_status = "master";
            };
            misc = {
              force_default_wallpaper = 0;
            };
          };
        };

        extraConfig = ''
          -- Monitor
          hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })

          -- Autostart
          hl.on("hyprland.start", function()
            hl.exec_cmd("systemctl --user import-environment")
            hl.exec_cmd("avizo-service")
            hl.exec_cmd("mako")
            hl.exec_cmd("eval $(ssh-agent -s)")
            hl.exec_cmd("eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)")
          end)

          -- Environment variables
          hl.env("XCURSOR_SIZE", "24")
          hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
          hl.env("QT_QPA_PLATFORM", "wayland")

          -- Bezier curve and animations
          hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
          hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
          hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default",  style = "popin 80%" })
          hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
          hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
          hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
          hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

          -- Window rules
          hl.window_rule({ match = { class = "ghostty" },                                 workspace = "1" })
          hl.window_rule({ match = { class = "wezterm" },                                  workspace = "1" })
          hl.window_rule({ match = { class = "obsidian" },                                 workspace = "2" })
          hl.window_rule({ match = { class = "zen" },                                      workspace = "3" })
          hl.window_rule({ match = { class = "^(zed)$" },                              workspace = "4" })
          hl.window_rule({ match = { class = "^(codium%-url%-handler)$" },             workspace = "4" })
          hl.window_rule({ match = { class = "^(wine)$" },                             workspace = "4" })
          hl.window_rule({ match = { class = "^(discord)$" },                          workspace = "5" })
          hl.window_rule({ match = { class = "^(com%.github%.finefindus%.eyedropper)$" }, float = true })

          -- Modifier keys
          local mod  = "SUPER + ALT"
          local mod2 = "SUPER + ALT + CTRL"

          -- Application binds
          hl.bind(mod .. " + t", hl.dsp.exec_cmd("ghostty"))
          hl.bind(mod .. " + g", hl.dsp.exec_cmd("ghostty"))
          hl.bind(mod .. " + n", hl.dsp.exec_cmd("obsidian"))
          hl.bind(mod .. " + w", hl.dsp.exec_cmd("zen"))
          hl.bind(mod .. " + z", hl.dsp.exec_cmd("zed"))
          hl.bind(mod .. " + d", hl.dsp.exec_cmd("discord"))

          -- Window management
          hl.bind(mod .. " + q", hl.dsp.window.close())
          hl.bind(mod .. " + c", hl.dsp.exec_cmd("hyprctl reload"))
          hl.bind(mod .. " + f", hl.dsp.window.fullscreen())
          hl.bind(mod2 .. " + space", hl.dsp.window.float({ action = "toggle" }))

          -- Launcher
          hl.bind(mod .. " + o", hl.dsp.exec_cmd("wofi --show drun"))
          hl.bind(mod2 .. " + o", hl.dsp.exec_cmd("wofi --show drun"))

          -- Screenshots
          hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
          hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast save area ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d-%H%M%S.png')"))

          -- Lock screen
          hl.bind("SUPER + l", hl.dsp.exec_cmd("hyprlock"))

          -- Focus movement
          hl.bind(mod .. " + h",     hl.dsp.focus({ direction = "left" }))
          hl.bind(mod .. " + l",     hl.dsp.focus({ direction = "right" }))
          hl.bind(mod .. " + k",     hl.dsp.focus({ direction = "up" }))
          hl.bind(mod .. " + j",     hl.dsp.focus({ direction = "down" }))
          hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
          hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
          hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
          hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

          -- Window movement
          hl.bind(mod2 .. " + h",     hl.dsp.window.move({ direction = "left" }))
          hl.bind(mod2 .. " + l",     hl.dsp.window.move({ direction = "right" }))
          hl.bind(mod2 .. " + k",     hl.dsp.window.move({ direction = "up" }))
          hl.bind(mod2 .. " + j",     hl.dsp.window.move({ direction = "down" }))
          hl.bind(mod2 .. " + left",  hl.dsp.window.move({ direction = "left" }))
          hl.bind(mod2 .. " + right", hl.dsp.window.move({ direction = "right" }))
          hl.bind(mod2 .. " + up",    hl.dsp.window.move({ direction = "up" }))
          hl.bind(mod2 .. " + down",  hl.dsp.window.move({ direction = "down" }))

          -- Workspace switching + move to workspace
          for i = 1, 10 do
            local key = i % 10
            hl.bind(mod .. " + " .. key,  hl.dsp.focus({ workspace = i }))
            hl.bind(mod2 .. " + " .. key, hl.dsp.window.move({ workspace = i }))
          end

          -- Layout splitting
          hl.bind(mod .. " + minus",     hl.dsp.layout("splitv"))
          hl.bind(mod .. " + backslash", hl.dsp.layout("splith"))

          -- Mouse binds
          hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          -- Media keys
          hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("lightctl up"))
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl down"))
          hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("volumectl -u up"))
          hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("volumectl -u down"))
          hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("volumectl toggle-mute"))
          hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("volumectl -m toggle-mute"))

          -- Resize submap
          hl.bind(mod .. " + r", hl.dsp.submap("resize"))
          hl.define_submap("resize", function()
            hl.bind("h",      hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
            hl.bind("l",      hl.dsp.window.resize({ x = 10,  y = 0, relative = true }))
            hl.bind("k",      hl.dsp.window.resize({ x = 0,   y = -10, relative = true }))
            hl.bind("j",      hl.dsp.window.resize({ x = 0,   y = 10, relative = true }))
            hl.bind("left",   hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
            hl.bind("right",  hl.dsp.window.resize({ x = 10,  y = 0, relative = true }))
            hl.bind("up",     hl.dsp.window.resize({ x = 0,   y = -10, relative = true }))
            hl.bind("down",   hl.dsp.window.resize({ x = 0,   y = 10, relative = true }))
            hl.bind("escape", hl.dsp.submap("reset"))
            hl.bind("return", hl.dsp.submap("reset"))
          end)
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
                on-click = "activate";
                persistent-workspaces = {
                  "*" = 10;
                };
                format-icons = {
                  "1" = "󰲠";
                  "2" = "󰲢";
                  "3" = "󰲤";
                  "4" = "󰲦";
                  "5" = "󰲨";
                  "6" = "󰲪";
                  "7" = "󰲬";
                  "8" = "󰲮";
                  "9" = "󰲰";
                  "10" = "󰿬";
                  "active" = "";
                  "default" = "";
                  "empty" = "";
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
              font-family: "Symbols Nerd Font", "mononoki Nerd Font", monospace;
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
            #workspaces button.active {
              color: #24283b;
              background-color: #7aa2f7;
              border-radius: 5px;
            }
            #workspaces button:hover {
              background-color: #7dcfff;
              color: #24283b;
              border-radius: 5px;
            }
            #workspaces button.empty {
              color: #565f89;
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
            "--no-default-browser-check"
          ];
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Linux Desktop Services
      # ─────────────────────────────────────────────────────────────────────────
      services = {
        # Dropbox sync
        dropbox.enable = true;

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
            preload = [ "${self}/assets/backgrounds/wallpaper_pixel_neon.png" ];
            wallpaper = [ ",${self}/assets/backgrounds/wallpaper_pixel_neon.png" ];
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
          # gearlever
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
          # hyprlock — managed by programs.hyprlock.enable
          # hypridle — managed by services.hypridle.enable
          wf-recorder
          grimblast
          mako
          grim
          slurp
          alacritty
          dmenu
          # wofi — managed by programs.wofi.enable
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
          # fuzzel — managed by programs.fuzzel.enable

          # Gaming / Entertainment
          steam
          discord
        ]
        ++ (with flake.inputs; [
          zen-browser.packages."x86_64-linux".twilight
          nix-alien.packages."x86_64-linux".nix-alien
        ]);

      # ─────────────────────────────────────────────────────────────────────────
      # Linux Desktop Configuration Files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        # Shared assets (backgrounds)
        backgrounds = {
          target = ".assets/backgrounds";
          source = "${self}/assets/backgrounds";
          recursive = true;
        };
      };

      # ===========================================
      # Flatpak (declarative management)
      # ===========================================
      services.flatpak = {
        enable = true;
        remotes = {
          "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
          "GeForceNOW" = "https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo";
        };
        packages = [
          # "flathub:app/org.onlyoffice.desktopeditors//stable"
          "flathub:app/org.freedesktop.Platform//24.08"
          "flathub:app/org.freedesktop.Sdk//24.08"
          "GeForceNOW:app/com.nvidia.geforcenow//stable"
        ];
        overrides = {
          "global".Context = {
            sockets = [
              "wayland"
              "!x11"
              "fallback-x11"
            ];
          };
          "com.nvidia.geforcenow" = {
            Environment = {
              "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
            };
            Context.sockets = [
              "wayland"
              "!x11"
              "!fallback-x11"
            ];
          };
        };
      };

    };
}
