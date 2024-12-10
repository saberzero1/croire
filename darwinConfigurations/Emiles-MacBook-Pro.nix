# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "Emiles-MacBook-Pro";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."emile".home = "/Users/emile";

  # Enable home-manager for "emile" user
  home-manager.users."emile" = {
    imports = [ (self + /configurations/home/emile.nix) ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

/*
  { inputs, ... }@flakeContext:
  let
  username = "emile";
  darwinModule =
      {
        config,
        lib,
        pkgs,
        home-manager,
        ...
      }:
      {
        imports = [
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
          # inputs.self.darwinModules.casks
          # inputs.self.darwinModules.dock
          # inputs.self.darwinModules.files
          inputs.self.darwinModules.git
          # inputs.self.darwinModules.home-settings
          # inputs.self.darwinModules.packages
          inputs.self.darwinModules.security
          inputs.self.darwinModules.home
          {
            #nixpkgs.overlays = [
            #  inputs.self.overlays
            #];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
        ];
        system = {
          defaults = {
            LaunchServices = {
              LSQuarantine = false;
            };

            NSGlobalDomain = {
              AppleShowAllExtensions = true;
              ApplePressAndHoldEnabled = false;

              # 120, 90, 60, 30, 12, 6, 2
              KeyRepeat = 2;

              # 120, 94, 68, 35, 25, 15
              InitialKeyRepeat = 15;

              "com.apple.mouse.tapBehavior" = 1;
              "com.apple.sound.beep.volume" = 0.0;
              "com.apple.sound.beep.feedback" = 0;

              AppleKeyboardUIMode = null;
            };

            dock = {
              autohide = false;
              show-recents = false;
              launchanim = true;
              orientation = "bottom";
              tilesize = 48;
              wvous-bl-corner = 11; # bottom-left; Set to Launchpad
              wvous-br-corner = 1; # bottom-right; Disabled
              wvous-tl-corner = 1; # top-left; Disabled
              wvous-tr-corner = 1; # top-right; Disabled
            };

            finder = {
              _FXShowPosixPathInTitle = false;
              AppleShowAllFiles = true;
              AppleShowAllExtensions = true;
              ShowPathbar = true;
              ShowStatusBar = true;
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
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          #pkgs.vim
          pkgs.just
          pkgs.git
        ];

        # Necessary for using flakes on this system.
        nix.settings = {
          experimental-features = "nix-command flakes";
          extra-nix-path = "nixpkgs=flake:nixpkgs";
        };

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system = {
          # configurationRevision = self.rev or self.dirtyRev or null;
          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          stateVersion = 5;
        };

        # The platform the configuration will be used on.
        nixpkgs = {
          hostPlatform = "aarch64-darwin";
          config = {
            allowUnfree = true;
            # allowBroken = true;
            # allowInsecure = false;
            # allowUnsupportedSystem = true;
          };
        };

        # programs.home-manager.enable = true;

        security.pam.enableSudoTouchIdAuth = true;
      };
  in

  #inputs.nixpkgs.lib.darwinSystem {
  inputs.darwin.lib.darwinSystem {
  specialArgs = {
      inherit username;
  } // inputs;
  modules = [
      darwinModule
  ];
  system = "aarch64-darwin";
  # Build darwin flake using:
  # $ darwin-rebuild build --flake .#Emiles-MacBook-Pro
  # darwinConfigurations."Emiles-MacBook-Pro" = nix-darwin.lib.darwinSystem {
  #   modules = [ configuration ];
  # };
  }
*/
