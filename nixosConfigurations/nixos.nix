{ inputs, ... }@flakeContext:
let
  nixosModule = { config, lib, pkgs, ... }: {
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
      }
    ];
    config = {
      boot = {
        hardwareScan = true;
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
        };
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
        pulseaudio = {
          enable = false;
        };
      };
      networking = {
        dhcpcd = {
          enable = true;
        };
        networkmanager = {
          enable = true;
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
        hostPlatform = lib.mkDefault "x86_64-linux";
      };
      powerManagement = {
        cpuFreqGovernor = "performance";
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
        xserver = {
          desktopManager = {
            gnome = {
              enable = true;
            };
          };
          displayManager = {
            autoLogin = {
              enable = true;
              user = "saberzero1";
            };
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
      sound = {
        enable = true;
      };
      system = {
        stateVersion = "23.11";
      };
      systemd = {
        services = {
          "autovt@tty1" = {
            enable = false;
          };
          "getty@tty1" = {
            enable = false;
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
  modules = [
    nixosModule
  ];
  system = "x86_64-linux";
}
