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
    ];
    config = {
      boot = {
        extraModulePackages = [ ];
        hardwareScan = true;
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "usbhid"
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
          device = "/dev/disk/by-uuid/951a61f8-b425-4bfe-8eae-44b0986c1fc1";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/812D-2A15";
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
      swapDevices = [
        {
          device = "/dev/disk/by-uuid/abb6997f-138e-42ad-a312-00c225b18520";
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
              "docker"
            ];
            name = "saberzero1";
          };
        };
      };
      virtualisation = {
        docker = {
          enable = true;
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
