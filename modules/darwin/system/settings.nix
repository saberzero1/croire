{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  primaryUser = "emile";
  primaryUserHome = "/Users/${primaryUser}";
in
{
  # Configure macOS system
  # More examples => https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/rich-demo/modules/system.nix
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
        # customize Hot Corners
        wvous-bl-corner = 11; # bottom-left - Launchpad
        wvous-br-corner = 4; # bottom-right - Desktop
        wvous-tl-corner = 1; # top-left; Disabled
        wvous-tr-corner = 1; # top-right; Disabled

        mru-spaces = false; # Don't use most recently used spaces
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllFiles = true; # show hidden files
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      WindowManager = {
        EnableTiledWindowMargins = false;
      };

      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = true;
        Bluetooth = true;
        # Display = true;
        # FocusModes = true;
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

      WindowManager = {
        StandardHideDesktopIcons = false;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
          _HIHideMenuBar = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
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

    activationScripts = {
      postActivation.text = ''
        echo "Running postActivation script"
        apps_source="${primaryUserHome}/Applications/Home Manager Apps"
        moniker="Nix Trampolines"
        app_target_base="$HOME/Applications"
        app_target="$app_target_base/$moniker"
        mkdir -p "$app_target"
        ${pkgs.rsync}/bin/rsync --archive --checksum --chmod=-w --copy-unsafe-links --delete "$apps_source/" "$app_target"

        # echo "Cleaning Neovim plugin cache"
        # sudo rm -rf "${primaryUserHome}/.cache/nvim/luac/*"
        # sudo rm -rf "${primaryUserHome}/.config/nvim"
        # echo "Cleaning Neovim plugin cache done"

        # echo "Setting up Yabai"
        # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(from-HEAD)
        # codesign -fs "yabai-cert" "$(/opt/homebrew/bin/brew --prefix yabai)/bin/yabai"
        # echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(/usr/bin/shasum -a 256 /opt/homebrew/bin/yabai | cut -d " " -f 1) /opt/homebrew/bin/yabai --load-sa" | sudo tee /private/etc/sudoers.d/yabai
        # /opt/homebrew/bin/yabai -m signal --add event=dock_did_restart action="sudo /opt/homebrew/bin/yabai --load-sa"
        # sudo /opt/homebrew/bin/yabai --load-sa
        # echo "Yabai setup done"

        # echo "Installing LazyVim"
        # mkdir -p "${primaryUserHome}/.config/nvim"
        # cp -r "${self}/programs/nvim" "${primaryUserHome}/.config"
        # echo "Installing LazyVim done"

        # Custom additions
        # echo "Setting tmux-sessionizer permissions"
        # sudo chmod +x "$HOME/.config/tmux/scripts/tmux-sessionizer"

        # echo "Setting up Sketchybar"
        # sudo rm -rf "${primaryUserHome}/.config/sketchybar"
        # cp -r "${self}/programs/sketchybar" "${primaryUserHome}/.config/sketchybar"
        # sudo chmod +x "${primaryUserHome}/.config/sketchybar/sketchybarrc"
        # sudo mkdir -p "${primaryUserHome}/.local/share/sketchybar_lua"
        # sudo cp "${pkgs.sbarlua}/lib/lua/5.4/sketchybar.so" "${primaryUserHome}/.local/share/sketchybar_lua/sketchybar.so"
        # sudo chmod +x "${primaryUserHome}/.local/share/sketchybar_lua/sketchybar.so"
        # cd "${primaryUserHome}/.config/sketchybar/helpers/menus"
        # make
        # cd -
        # cd "${primaryUserHome}/.config/sketchybar/helpers/event_providers"
        # make
        # cd -
        # echo "Sketchybar setup done"

        sudo chown -R ${primaryUser}:staff "${primaryUserHome}/.config"
        # skhd --restart-service
      '';
    };

  };

}
