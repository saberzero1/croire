{ inputs, ... }@flakeContext:
let
  nixosModule = { config, lib, pkgs, username, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.self.homeConfigurations.saberzero1.nixosModule
      inputs.self.nixosModules.applications
      inputs.self.nixosModules.browser
      inputs.self.nixosModules.console
      inputs.self.nixosModules.desktop
      inputs.self.nixosModules.development
      inputs.self.nixosModules.git
      inputs.self.nixosModules.programming_languages
      inputs.self.nixosModules.security
      inputs.self.nixosModules.system
      inputs.self.nixosModules.utils
      inputs.self.nixosModules.workflow
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
    config = {
      boot = {
        hardwareScan = true;
        loader = {
          efi = {
            canTouchEfiVariables = true;
          };
          systemd-boot = {
            enable = true;
          };
        };
      };
      hardware = {
        enableRedistributableFirmware = true;
        pulseaudio = {
          enable = false;
        };
      };
      networking = {
        hostName = "nixos";
        networkmanager = {
          enable = true;
          wifi = {
            backend = "wpa_supplicant";
          };
        };
        wireless = {
          allowAuxiliaryImperativeNetworks = true;
          dbusControlled = true;
          userControlled = {
            enable = true;
            group = "networkmanager";
          };
        };
      };
      nix = {
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
        };
      };
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };
      security = {
        rtkit = {
          enable = true;
        };
      };
      services = {
        pipewire = {
          alsa = {
            enable = true;
            support32Bit = true;
          };
          enable = true;
          pulse = {
            enable = true;
          };
        };
        printing = {
          enable = true;
        };
        displayManager = {
          autoLogin = {
            enable = true;
            user = "saberzero1";
          };
        };
        xserver = {
          displayManager = {
            gdm = {
              enable = true;
            };
          };
          enable = true;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
      };
      # sound = {
      #   enable = true;
      # };
      systemd = {
        services = {
          "autovt@tty1" = {
            enable = true;
          };
          "getty@tty1" = {
            enable = true;
          };
        };
      };
      users = {
        users = {
          saberzero1 = {
            name = "saberzero1";
          };
        };
      };
    };
  };
in
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit username;
  } // inputs;
  modules = [
    nixosModule
  ];
  system = "x86_64-linux";
}
