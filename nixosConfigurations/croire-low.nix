{ inputs, ... }@flakeContext:
let
  username = inputs.self.username;
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
        #nixpkgs.overlays = [
        #  inputs.self.overlays
        #];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
      inputs.hyprland.nixosModules.default
      {
        programs.hyprland = {
          enable = true;
          xwayland = {
            enable = true;
          };
        };
      }
    ];
    config = {
      boot = {
        extraModulePackages = [ ];
        hardwareScan = true;
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "vmd"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };
        kernelModules = [
          "kvm-intel"
        ];
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          efi = {
            canTouchEfiVariables = true;
          };
          systemd-boot = {
            enable = true;
          };
        };
      };
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/9016f5b3-7a10-431b-9e6b-88d72d0ceee4";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/1F95-4581";
          fsType = "vfat";
        };
      };
      hardware = {
        enableRedistributableFirmware = true;
        pulseaudio = {
          enable = false;
        };
      };
      networking = {
        hostName = "croire-low";
        networkmanager = {
          enable = true;
          wifi = {
            backend = "wpa_supplicant";
          };
        };
        useDHCP = false;
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
        hostPlatform = lib.mkDefault "x86_64-linux";
      };
      powerManagement = {
        cpuFreqGovernor = "ondemand";
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
        # espanso = {
        #   enable = true;
        #   package = config.programs.espanso.package;
        #   serviceConfig = {
        #     execStart = "${config.programs.espanso.package}/bin/espanso start";
        #     Restart = "always";
        #     RestartSec = 1;
        #   };
        # };
      };
      # sound = {
      #   enable = true;
      # };
      swapDevices = [
        {
          device = "/dev/disk/by-uuid/508b0146-f5ee-4b57-9a1a-c76809ca5597";
        }
      ];
      system = {
        stateVersion = "24.05";
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
            extraGroups = [
              "wheel"
              "networkmanager"
              "plugdev"
              "input"
            ];
            name = "saberzero1";
          };
        };
      };
      virtualisation = {
        docker = {
          # Don't enable docker on low-spec hardware.
          enable = false;
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
