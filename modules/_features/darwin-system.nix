# Dendritic feature module: Darwin system configuration
# Provides unified Darwin system configuration (fonts, security, settings)
# Exports: darwinModules.system
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.darwinModules.system =
    {
      flake,
      pkgs,
      config,
      lib,
      ...
    }:
    let
      primaryUser = "emile";
      primaryUserHome = "/Users/${primaryUser}";
      wallpaper = "${self}/assets/backgrounds/wallpaper_pixel_neon.png";
    in
    {
      # ===========================================
      # Required Imports
      # ===========================================
      imports = [
        flake.inputs.determinate.darwinModules.default
        flake.inputs.nix-homebrew.darwinModules.nix-homebrew
        # Import dock module (has custom options)
        ./_imports/darwin/dock
        # Import packages (homebrew casks, formulae, masApps, taps)
        ./_imports/darwin/packages
        # Shared fonts
        ./_imports/fonts.nix
      ];

      # ===========================================
      # Nix Settings
      # ===========================================
      nix = {
        enable = false;
        settings = {
          trusted-users = [
            "root"
            "emile"
          ];
          ssl-cert-file = "/etc/nix/ca_cert.pem";
        };
        channel.enable = true;
      };

      # Determinate Nix settings (written to /etc/nix/nix.custom.conf)
      determinateNix.customSettings =
        let
          cache = import (self + /modules/_features/_imports/binary-caches.nix);
        in
        {
          eval-cores = 0;
          experimental-features = "nix-command flakes";
          trusted-users = [
            "root"
            "emile"
          ];
          inherit (cache) substituters trusted-public-keys;
        };

      # Dock configuration
      local = {
        dock.enable = true;
        dock.entries = [
          { path = "/Applications/Wavebox.app"; }
          { path = "/Applications/Ghostty.app"; }
          { path = "/Applications/Obsidian.app"; }
        ];
      };

      # ===========================================
      # Shell Configuration
      # ===========================================
      # Add nushell to the list of allowed shells
      environment.shells = with pkgs; [
        bashInteractive
        zsh
        nushell
      ];

      # Enable shell programs
      programs.bash.enable = true;
      programs.zsh.enable = true;

      # Fonts are imported from ./_imports/fonts.nix

      # ===========================================
      # Security
      # ===========================================
      security = {
        pam = {
          services.sudo_local = {
            # Use TouchID for `sudo` authentication
            touchIdAuth = true;
            # Fixes TouchID not working with tmux
            reattach = true;
          };
        };

        pki = {
          certificateFiles = builtins.filter (path: builtins.pathExists path) [
            "/etc/ssl/cert.pem"
            "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "/etc/nix/ca_cert.pem"
          ];
        };
      };

      # ===========================================
      # System Packages
      # ===========================================
      environment = {
        systemPackages =
          let
            sharedPkgs = import ./_imports/shared-packages.nix { inherit pkgs; };
          in
          sharedPkgs.kubernetes
          ++ sharedPkgs.devTools
          ++ sharedPkgs.security
          ++ sharedPkgs.git
          ++ (with pkgs; [
            # Darwin-specific security
            openssh
            libressl
            cacert

            # Apple development
            xcodes
            apple-sdk

            # Sketchybar
            lua54Packages.lua
            sketchybar-app-font
            sbarlua

            # Shell
            nushell
          ]);

        variables = {
          NIX_CONFIG = ''
            build-users-group = nixbld
            extra-trusted-users = emile
          '';
        };
      };

      # ===========================================
      # Programs
      # ===========================================
      programs = {
        gnupg = {
          agent = {
            enable = true;
            enableSSHSupport = true;
          };
        };
      };

      # ===========================================
      # System Settings (macOS Defaults)
      # ===========================================
      system = {
        defaults = {
          LaunchServices = {
            LSQuarantine = false;
          };

          # Requires System Settings > Privacy & Security > Full Disk Access
          universalaccess = {
            reduceMotion = true;
            reduceTransparency = true;
            mouseDriverCursorSize = 1.5;
          };

          loginwindow = {
            GuestEnabled = false;
          };

          dock = {
            autohide = true;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.0;
            show-recents = false;
            launchanim = true;
            orientation = "bottom";
            tilesize = 48;
            # Hot Corners
            wvous-bl-corner = 11; # bottom-left - Launchpad
            wvous-br-corner = 4; # bottom-right - Desktop
            wvous-tl-corner = 1; # top-left - Disabled
            wvous-tr-corner = 1; # top-right - Disabled
            mru-spaces = false; # Don't use most recently used spaces
          };

          finder = {
            _FXShowPosixPathInTitle = true;
            AppleShowAllFiles = true;
            AppleShowAllExtensions = true;
            FXEnableExtensionChangeWarning = false;
            QuitMenuItem = true;
            ShowPathbar = true;
            ShowStatusBar = true;
          };

          trackpad = {
            Clicking = true;
            TrackpadThreeFingerDrag = true;
          };

          WindowManager = {
            EnableTiledWindowMargins = false;
            StandardHideDesktopIcons = false;
          };

          controlcenter = {
            AirDrop = false;
            BatteryShowPercentage = true;
            Bluetooth = true;
            NowPlaying = true;
            Sound = true;
          };

          NSGlobalDomain = {
            # Disable natural scrolling
            "com.apple.swipescrolldirection" = false;
          };

          spaces = {
            spans-displays = false;
          };

          CustomUserPreferences = {
            NSGlobalDomain = {
              WebKitDeveloperExtras = true;
              _HIHideMenuBar = true;
            };
            "com.apple.finder" = {
              ShowExternalHardDrivesOnDesktop = true;
              ShowHardDrivesOnDesktop = true;
              ShowMountedServersOnDesktop = true;
              ShowRemovableMediaOnDesktop = true;
              _FXSortFoldersFirst = true;
              FXDefaultSearchScope = "SCcf";
            };
            "com.apple.desktopservices" = {
              DSDontWriteNetworkStores = true;
              DSDontWriteUSBStores = true;
            };
            "com.apple.screencapture" = {
              location = "~/Desktop";
              type = "png";
            };
            "com.apple.symbolichotkeys" = {
              AppleSymbolicHotKeys = {
                # Disable various system hotkeys to avoid conflicts
                "7" = {
                  enabled = false;
                };
                "8" = {
                  enabled = false;
                };
                "9" = {
                  enabled = false;
                };
                "10" = {
                  enabled = false;
                };
                "11" = {
                  enabled = false;
                };
                "12" = {
                  enabled = false;
                };
                "13" = {
                  enabled = false;
                };
                "15" = {
                  enabled = false;
                };
                "16" = {
                  enabled = false;
                };
                "17" = {
                  enabled = false;
                };
                "18" = {
                  enabled = false;
                };
                "19" = {
                  enabled = false;
                };
                "20" = {
                  enabled = false;
                };
                "21" = {
                  enabled = false;
                };
                "22" = {
                  enabled = false;
                };
                "23" = {
                  enabled = false;
                };
                "24" = {
                  enabled = false;
                };
                "25" = {
                  enabled = false;
                };
                "26" = {
                  enabled = false;
                };
                "27" = {
                  enabled = false;
                };
                "32" = {
                  enabled = false;
                };
                "33" = {
                  enabled = false;
                };
                "34" = {
                  enabled = false;
                };
                "35" = {
                  enabled = false;
                };
                "36" = {
                  enabled = false;
                };
                "37" = {
                  enabled = false;
                };
                "52" = {
                  enabled = false;
                };
                "57" = {
                  enabled = false;
                };
                "59" = {
                  enabled = false;
                };
                "60" = {
                  enabled = false;
                };
                "61" = {
                  enabled = false;
                };
                # Disable 'Cmd + Space' for Spotlight Search
                "64" = {
                  enabled = false;
                };
                # Disable 'Cmd + Alt + Space' for Finder search window
                "65" = {
                  enabled = false;
                };
                "79" = {
                  enabled = false;
                };
                "80" = {
                  enabled = false;
                };
                "81" = {
                  enabled = false;
                };
                "82" = {
                  enabled = false;
                };
                "98" = {
                  enabled = false;
                };
                "118" = {
                  enabled = false;
                };
                "160" = {
                  enabled = false;
                };
                "162" = {
                  enabled = false;
                };
                "163" = {
                  enabled = false;
                };
                "175" = {
                  enabled = false;
                };
                "179" = {
                  enabled = false;
                };
                "190" = {
                  enabled = false;
                };
                "222" = {
                  enabled = false;
                };
              };
            };
          };
        };

        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToControl = true;
          swapLeftCommandAndLeftAlt = false;
          swapLeftCtrlAndFn = false;
        };

        # ===========================================
        # Activation Scripts
        # ===========================================
        activationScripts = {
          # Fix for Nix not using macOS system CA certificates
          "ssl-ca-cert-fix".text = ''
            if [ ! -f /etc/nix/ca_cert.pem ]; then
              security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
              security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
              cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
              sudo mkdir -p /etc/nix
              sudo mv /tmp/ca_cert.pem /etc/nix/
            fi
          '';

          postActivation.text = ''
            echo "Running postActivation script"

            # Ensure nushell is in /etc/shells
            if ! grep -q "/run/current-system/sw/bin/nu" /etc/shells; then
              echo "Adding nushell to /etc/shells"
              echo "/run/current-system/sw/bin/nu" | sudo tee -a /etc/shells > /dev/null
            fi

            apps_source="${primaryUserHome}/Applications/Home Manager Apps"
            moniker="Nix Trampolines"
            app_target_base="$HOME/Applications"
            app_target="$app_target_base/$moniker"
            mkdir -p "$app_target"
            ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"

            echo "Setting wallpaper"
            /usr/bin/osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${wallpaper}\"" || echo "Warning: Failed to set wallpaper (Finder timeout). This is non-critical."

            sudo chown -R ${primaryUser}:staff "${primaryUserHome}/.config"
          '';
        };
      };
    };
}
