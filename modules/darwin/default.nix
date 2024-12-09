# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{ flake
, pkgs
, lib
, ...
}:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    ./dock
  ];
  # Use TouchID for `sudo` authentication
  security.pam.enableSudoTouchIdAuth = true;

  # These users can add Nix caches.
  nix.settings.trusted-users = [
    "root"
    "emile"
  ];

  # Configure macOS system
  # More examples => https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/rich-demo/modules/system.nix
  system = {
    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };
      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
        # customize Hot Corners
        wvous-bl-corner = 11; # bottom-left - Launchpad
        wvous-br-corner = 4; # bottom-right - Desktop
        wvous-tl-corner = 1; # top-left; Disabled
        wvous-tr-corner = 1; # top-right; Disabled
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

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
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
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
      # swapLeftCommandAndLeftAlt = true;
      swapLeftCtrlAndFn = true;
    };
  };
  local = {
    dock.enable = true;
    dock.entries = [
      #{ path = "/Applications/Safari.app"; }
      { path = "/Applications/Wavebox.app"; }
      { path = "${pkgs.wezterm}/Applications/Wezterm.app"; }
    ];
  };
}
