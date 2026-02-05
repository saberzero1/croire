# Dendritic feature module: NixOS system configuration
# Provides unified NixOS system configuration (fonts, security, settings, hardware)
# Exports: nixosModules.system
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.nixosModules.system =
    {
      flake,
      pkgs,
      config,
      lib,
      ...
    }:
    let
      patchDesktop =
        pkg: appName: from: to:
        lib.hiPrio (
          pkgs.runCommand "$patched-desktop-entry-for-${appName}" { } ''
            ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
            ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
          ''
        );
      GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
    in
    {
      # Import shared fonts
      imports = [
        (self + /modules/_features/_imports/fonts.nix)
        # Binary caches
        ./_imports/binary-caches.nix
      ];

      # ===========================================
      # Fonts (NixOS-specific settings)
      # ===========================================
      fonts = {
        enableDefaultPackages = true;
        enableGhostscriptFonts = true;
        fontDir = {
          enable = true;
          decompressFonts = true;
        };
        fontconfig = {
          defaultFonts = {
            monospace = [ "Monaspace Neon" ];
          };
          enable = true;
        };
        # Additional NixOS-only fonts
        packages = with pkgs; [
          # JP Fonts
          migu
        ];
      };

      # ===========================================
      # Security
      # ===========================================
      security = {
        polkit.enable = true;
        rtkit.enable = true;

        doas = {
          enable = true;
          wheelNeedsPassword = true;
        };

        sudo = {
          enable = true;
          execWheelOnly = true;
          package = pkgs.sudo;
          wheelNeedsPassword = true;
          extraConfig = ''
            Defaults timestamp_timeout=60
          '';
        };

        pam = {
          services = {
            hyprlock = {
              enableGnomeKeyring = true;
              gnupg.enable = true;
            };
            login = {
              enableGnomeKeyring = true;
              gnupg.enable = true;
            };
          };
          # Fixes "Too many open files" errors
          loginLimits = [
            {
              domain = "*";
              type = "soft";
              item = "nofile";
              value = "65536";
            }
            {
              domain = "*";
              type = "hard";
              item = "nofile";
              value = "1048576";
            }
          ];
        };
      };

      # ===========================================
      # Environment
      # ===========================================
      environment = {
        pathsToLink = [ "/share/uwsm" ];

        sessionVariables = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
        };

        systemPackages =
          let
            sharedPkgs = import (self + /modules/_features/_imports/shared-packages.nix) { inherit pkgs; };
          in
          sharedPkgs.kubernetes
          ++ sharedPkgs.devTools
          ++ sharedPkgs.security
          ++ sharedPkgs.git
          ++ (with pkgs; [
            # NixOS-specific security
            seahorse
            sudo
            wpa_supplicant
            wpa_supplicant_gui

            # Desktop applications
            vlc
            (GPUOffloadApp steam "steam")
            obsidian
            discord
            steamtinkerlaunch
            wofi
            wofi-pass

            # GNOME
            gdm
            gnome-shell
            gnome-shell-extensions
            gnome-browser-connector
            gnome-remote-desktop
            nautilus
            nautilus-python
            nautilus-open-any-terminal

            # Remote desktop
            xrdp
            freerdp

            # Wayland & Hyprland
            albert
            wlsunset
            uwsm
            mako
            hyprland
            slurp
            grim
            kitty

            # Hyprland build dependencies
            libxau
            libxcb
            libexecinfo
            libnotify
            tracy
            wayland-protocols
            hyprland-protocols
            udis86

            # System utilities
            dbus
            vulkan-tools
            lsof
            ghostty
            pre-commit

            # Keyboard & hardware
            libusb1
            wally-cli
            zsa-udev-rules
            qmk

            # GTK & webkit
            gtk3
            webkitgtk_6_0
            libuuid

            # Wine
            wineWowPackages.stable
            wine
            (pkgs.wine.override { wineBuild = "wine64"; })
            wine64
            wineWowPackages.staging
            winetricks

            # Document viewers
            evince
            foliate

            # Audio
            pulseaudioFull
            avizo
            libnotify
            fuzzel

            # Core utilities
            gnugrep
            gnused
            glib
            glibc
            libxml2
            libxslt
            zlib
            pkg-config
            nss
            libnss_nis
            curlFull
            iwgtk
            iperf2
            wget2
            gnumake
            _7zz
            parallel
            libavif
            libsoup_3

            # Graphics
            inkscape-with-extensions
            vscodium.fhs
            vscode-extensions.asvetliakov.vscode-neovim

            # Development (NixOS-specific)
            pipewire
            libnss_nis
            electron-chromedriver
          ]);

        gnome = {
          excludePackages = [
            pkgs.baobab
            pkgs.geary
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
            pkgs.gnome-photos
            pkgs.gnome-text-editor
            pkgs.gnome-tour
            pkgs.gnome-user-docs
            pkgs.orca
            pkgs.simple-scan
            pkgs.totem
            pkgs.yelp
          ];
        };
      };

      # ===========================================
      # Console
      # ===========================================
      console = {
        enable = true;
        font = "Monaspace Neon";
        packages = with pkgs; [
          monaspace
          terminus_font
        ];
        keyMap = "us";
      };

      # ===========================================
      # XDG
      # ===========================================
      xdg = {
        mime = {
          enable = true;
          defaultApplications = {
            "text/html" = [ "zen.desktop" ];
            "x-scheme-handler/http" = [ "zen.desktop" ];
            "x-scheme-handler/https" = [ "zen.desktop" ];
            "x-scheme-handler/ftp" = [ "zen.desktop" ];
            "x-scheme-handler/chrome" = [ "zen.desktop" ];
            "x-scheme-handler/about" = [ "zen.desktop" ];
            "x-scheme-handler/unknown" = [ "zen.desktop" ];
            "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
            "application/x-extension-htm" = [ "zen.desktop" ];
            "application/x-extension-html" = [ "zen.desktop" ];
            "application/x-extension-shtml" = [ "zen.desktop" ];
            "application/xhtml+xml" = [ "zen.desktop" ];
            "application/x-extension-xhtml" = [ "zen.desktop" ];
            "application/x-extension-xht" = [ "zen.desktop" ];
          };
        };
        portal = {
          enable = true;
          xdgOpenUsePortal = true;
        };
      };

      # ===========================================
      # Programs
      # ===========================================
      programs = {
        gnupg = {
          agent = {
            enable = true;
            enableSSHSupport = false;
            settings = { };
          };
          package = pkgs.gnupg;
        };

        ssh = {
          package = pkgs.openssh;
          startAgent = true;
          extraConfig = ''
            AddKeysToAgent yes
          '';
        };

        seahorse.enable = true;
        yubikey-touch-detector.enable = false;

        nautilus-open-any-terminal = {
          enable = true;
          terminal = "wezterm";
        };

        uwsm = {
          enable = true;
          waylandCompositors = {
            hyprland = {
              prettyName = "Hyprland";
              comment = "Hyprland compositor managed by UWSM";
              binPath = "/run/current-system/sw/bin/start-hyprland";
            };
          };
        };

        hyprland = {
          enable = true;
          withUWSM = true;
        };

        nano.enable = false;

        nix-ld = {
          enable = true;
          package = pkgs.nix-ld;
        };

        npm = {
          enable = true;
          npmrc = ''
            '''
              prefix = '''''${config.home.homeDirectory}/.npm
              color=true
            '''
          '';
        };

        steam = {
          enable = true;
          package = pkgs.steam;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          protontricks = {
            enable = true;
            package = pkgs.protontricks;
          };
        };
      };

      # ===========================================
      # Services
      # ===========================================
      services.displayManager = {
        autoLogin = {
          enable = true;
          user = "saberzero1";
        };
        defaultSession = "hyprland-uwsm";
      };

      # ===========================================
      # Systemd
      # ===========================================
      systemd = {
        packages = with pkgs; [ uwsm ];
        user = {
          tmpfiles.rules = [ ];
          services = {
            rCloneMounts = {
              description = "Mount all rClone configurations";
              after = [ "network-online.target" ];
              serviceConfig = {
                Type = "forking";
                ExecStartPre = "${pkgs.writeShellScript "rClonePre" ''
                  remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
                  for remote in $remotes;
                  do
                  name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
                  /usr/bin/env mkdir -p $HOME/"$name"
                  done
                ''}";
                ExecStart = "${pkgs.writeShellScript "rCloneStart" ''
                  remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
                  for remote in $remotes;
                  do
                  name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
                  ${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount "$remote" "$name" &
                  done
                ''}";
                ExecStop = "${pkgs.writeShellScript "rCloneStop" ''
                  remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
                  for remote in $remotes;
                  do
                  name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
                  /usr/bin/env fusermount -u $HOME/"$name"
                  done
                ''}";
              };
              wantedBy = [ "default.target" ];
            };
          };
        };
      };

      # ===========================================
      # Hardware
      # ===========================================
      hardware = {
        keyboard = {
          qmk.enable = true;
          zsa.enable = true;
        };
        nvidia = {
          open = lib.mkDefault true;
          powerManagement = {
            enable = false;
            finegrained = false;
          };
          modesetting.enable = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
        graphics.enable = true;
      };

      # ===========================================
      # Locale
      # ===========================================
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LANGUAGE = "en_US.UTF-8";
          LC_ADDRESS = "nl_NL.UTF-8";
          LC_COLLATE = "en_US.UTF-8";
          LC_CTYPE = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "nl_NL.UTF-8";
          LC_MESSAGES = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "nl_NL.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "nl_NL.UTF-8";
          LC_TIME = "nl_NL.UTF-8";
        };
        supportedLocales = [
          "en_US.UTF-8/UTF-8"
          "nl_NL.UTF-8/UTF-8"
          "nl_NL/ISO-8859-1"
          "ja_JP.UTF-8/UTF-8"
        ];
      };

      # ===========================================
      # System Settings
      # ===========================================
      nix.channel.enable = true;
      system.switch.enable = true;

      zramSwap = {
        enable = true;
        memoryPercent = 50;
        algorithm = "zstd";
      };

      qt = {
        enable = true;
        platformTheme = "gnome";
        style = "adwaita-dark";
      };

      powerManagement.cpuFreqGovernor = "performance";
      appstream.enable = true;

      # ===========================================
      # User Activation Scripts
      # ===========================================
      system.userActivationScripts = {
        postUserActivation.text = ''
          echo "Cleaning Neovim plugin cache"
          sudo rm -rf "$HOME/.local/share/nvim/lazy"
          sudo rm -rf "$HOME/.cache/nvim/luac/*"
          sudo rm -rf "$HOME/.config/nvim"
          echo "Cleaning Neovim plugin cache done"

          echo "Setting tmux-sessionizer permissions"
        '';
      };
    };
}
