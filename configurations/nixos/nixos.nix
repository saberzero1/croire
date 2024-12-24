# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.fonts
    self.nixosModules.security
    self.nixosModules.services
    self.nixosModules.system
    inputs.nix-snapd.nixosModules.default
    {
      services.snap.enable = true;
    }
  ];

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config = {
      allowUnfree = true;
      allowBroken = true;
      nvidia.acceptLicense = true;
    };
    overlays = lib.attrValues self.overlays;
  };

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
    "/mnt/internal-hard-drive" = {
      device = "/dev/disk/by-uuid/b2f385b9-88bb-4300-9101-bd742b03111d";
      fsType = "auto";
      options = [
        "nosuid"
        "nodev"
        "nofail"
        "x-gvfs-show"
      ];
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    pulseaudio = {
      enable = false;
    };

    # https://discourse.nixos.org/t/issue-after-sound-option-was-removed-in-unstable/49394/8
    alsa = {
      enablePersistence = true;
    };

    nvidia = {
      modesetting = {
        enable = true;
      };
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    keyboard = {
      qmk = {
        enable = true;
      };
      zsa = {
        enable = true;
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" /*"amdgpu"*/ ];
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

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/abb6997f-138e-42ad-a312-00c225b18520";
    }
  ];

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

  networking.hostName = "nixos";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users = {
    groups = {
      plugdev = { };
    };
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users = {
      "saberzero1" = {
        extraGroups = [
          "wheel"
          "networkmanager"
          "plugdev"
          "docker"
          "input"
        ];
        name = "saberzero1";
        home = "/home/saberzero1";
        initialPassword = "changeme";
        expires = null;
        isNormalUser = true;
        useDefaultShell = true;
      };
    };
  };

  # Enable home-manager for "runner" user
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users."saberzero1" = {
      imports = [ (self + /configurations/home/saberzero1.nix) ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  # These users can add Nix caches.
  nix.settings = {
    experimental-features = "nix-command flakes";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
  };

  system = {
    stateVersion = "24.05";
  };

  # public key
  # programs.git.signing.key = "41AEE99107640F10";

  /*  specialArgs = {
      nixosPublicKey =
      if config.networking.hostName == "nixos" then "41AEE99107640F10"
      else if config.networking.hostName == "croire" then null
      else if config.networking.hostName == "croire-low" then "198769D1B0D0DF8C"
      else null;
      };*/
}
