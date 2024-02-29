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
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          luks = {
            devices = {
              luks-f3bc2b0a-5f98-4731-88c3-3999097ff40a = {
                device = "/dev/disk/by-uuid/f3bc2b0a-5f98-4731-88c3-3999097ff40a";
              };
            };
          };
        };
        kernelModules = [
          "kvm_intel"
        ];
        loader = {
          efi = {
            canTouchEfiVariables = true;
          };
          systemd-boot = {
            enable = true;
          };
        };
      };
      environment = {
        systemPackages = [
          pkgs.dhcpcd
        ];
      };
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/dd0b28e1-cb2d-463e-b921-493bedeee5ca";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/AEDC-A59F";
          fsType = "vfat";
        };
      };
      networking = {
        dhcpcd = {
          enable = true;
        };
        hostName = "nixos";
        networkmanager = {
          dhcp = "internal";
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
      programs = {
        hyprland = {
          enable = true;
        };
      };
      services = {
        printing = {
          enable = true;
        };
      };
      system = {
        stateVersion = "23.11";
      };
      users = {
        users = {
          saberzero1 = {
            name = "Emile Bangma";
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
