# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake
, pkgs
, lib
, config
, ...
}:
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
    hostPlatform.system = "x86_64-linux";
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
    kernelPackages = pkgs.linuxPackages_6_17;
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
    # https://discourse.nixos.org/t/issue-after-sound-option-was-removed-in-unstable/49394/8
    alsa = {
      enablePersistence = true;
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

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
      jack = {
        enable = true;
      };
      audio = {
        enable = true;
      };
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

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/508b0146-f5ee-4b57-9a1a-c76809ca5597";
    }
  ];

  system = {
    stateVersion = "24.11";
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

  virtualisation = {
    docker = {
      # Don't enable docker on low-spec hardware.
      enable = false;
    };
  };

  time = {
    timeZone = lib.mkForce "Europe/Amsterdam";
  };

}
