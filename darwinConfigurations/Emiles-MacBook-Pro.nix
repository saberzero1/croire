{ inputs, ... }@flakeContext:
let
  username = "emile";
  darwinModule = 
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.self.darwinModules.git
        inputs.self.darwinModules.security
        inputs.self.darwinConfigurations.home
        #inputs.home-manager.nixosModules.home-manager
        #inputs.self.homeConfigurations.saberzero1.nixosModule
        #inputs.self.nixosModules.applications
        #inputs.self.nixosModules.browser
        #inputs.self.nixosModules.console
        #inputs.self.nixosModules.desktop
        #inputs.self.nixosModules.development
        #inputs.self.nixosModules.git
        #inputs.self.nixosModules.programming_languages
        #inputs.self.nixosModules.security
        #inputs.self.nixosModules.system
        #inputs.self.nixosModules.utils
        #inputs.self.nixosModules.workflow
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
          };

          dock = {
            autohide = false;
            show-recents = false;
            launchanim = true;
            orientation = "bottom";
            tilesize = 48;
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
            EnableTiledWindowMargins = true;
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

      #programs.home-manager.enable = true;

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

