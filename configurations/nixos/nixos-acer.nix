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
    inputs.nix-snapd.nixosModules.default
    {
      services.snap.enable = false;
    }
  ];

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform.system = "x86_64-linux";
    config = {
      allowUnfree = true;
      allowBroken = true;
      nvidia.acceptLicense = true;
      cudaSupport = true;
      # Override libsoup with libsoup_3
      packageOverrides = pkgs: {
        libsoup = pkgs.libsoup_3;
        libsoup_2_4 = pkgs.libsoup_3;
      };
    };
    overlays = lib.attrValues self.overlays;
  };

  boot = {
    extraModulePackages = [ ];
    hardwareScan = true;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "thunderbolt"
        "rtsx_pci_sdmmc"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "nvidia_uvm"
      ];
      kernelModules = [ ];
      luks.devices = {
        "luks-32b0cce0-aa62-475b-ab71-4fb3a3d7c980" = {
          device = "/dev/disk/by-uuid/32b0cce0-aa62-475b-ab71-4fb3a3d7c980";
        };
      };
      systemd = {
        enable = true;
      };
    };
    kernelModules = [
      "kvm-amd"
      "nvidia_uvm"
    ];
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
      };
    };
    # Prevent USB sleep
    # postBootCommands = "echo -1 > /sys/module/usbcore/parameters/autosuspend";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e5d7f89a-1469-41fa-b257-90a6f387dcf3";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D7FD-45A1";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    # https://discourse.nixos.org/t/issue-after-sound-option-was-removed-in-unstable/49394/8

    alsa = {
      enablePersistence = true;
    };

    nvidia = {
      open = true;

      modesetting = {
        enable = true;
      };

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
          offloadCmdMainProgram = "nvidia-offload";
        };
        allowExternalGpu = true;
        # sync.enable = true;
        # reverseSync.enable = true;

        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:65:0:0";
      };
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

    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services = {
    pulseaudio = {
      enable = false;
    };

    xserver = {
      enable = true;
      videoDrivers = [
        "amdgpu"
        "nvidia"
        # "nouveau"
      ];
    };

    dnscrypt-proxy = {
      enable = true;
      # Settings reference:
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      settings = {
        ipv6_servers = true;
        require_dnssec = true;
        # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
        # query_log.file = "/var/log/dnscrypt-proxy/query.log";
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        # server_names = [ ... ];
        /*
          server_names = [
            "doh-cleanbrowsing-adult"
            "cleanbrowsing-adult-doh"
          ];
        */
      };
    };
  };

  networking = {
    hostName = "nixos-acer";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
      };
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.extraConfig = "nohook resolv.conf";
    wireless = {
      allowAuxiliaryImperativeNetworks = true;
      dbusControlled = true;
    };
  };

  swapDevices = [
    # {
    #   # device = "/dev/disk/by-uuid/baf9ca74-9273-4384-94d0-bfec444bffd4";
    #   device = "/dev/disk/by-uuid/9c8122d3-6cfc-4635-8214-0e31ab5587cb";
    # }
  ];

  systemd = {
    services = {
      "autovt@tty1" = {
        enable = false;
      };
      "getty@tty1" = {
        enable = false;
      };
      # Workaround for start vconsole-setup service error during boot
      # Remove this after they are done bikeshedding over here:
      # https://github.com/NixOS/nixpkgs/pull/430883
      systemd-vconsole-setup.after = [
        "local-fs.target"
      ];
    };
  };

  # networking.hostName = "nixos";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users = {
    groups = {
      plugdev = { };
    };
    mutableUsers = true;
    defaultUserShell = pkgs.nushell;
    users = {
      "saberzero1" = {
        extraGroups = [
          "wheel"
          "networkmanager"
          "plugdev"
          "docker"
          "input"
          "wpa_supplicant"
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
      imports = [ (self + /configurations/home/nixos/saberzero1.nix) ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  # These users can add Nix caches.
  nix = {
    enable = true;
    # package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      extra-nix-path = "nixpkgs=flake:nixpkgs";
      # lazy-trees = true;
      # eval-cores = 0; # Use all available CPU cores for evaluation
    };
  };

  system = {
    stateVersion = "25.11";
  };

  time = {
    timeZone = lib.mkForce "Europe/Amsterdam";
  };

  # public key
  # programs.git.signing.key = "41AEE99107640F10";

  /*
    specialArgs = {
     nixosPublicKey =
     if config.networking.hostName == "nixos" then "41AEE99107640F10"
     else if config.networking.hostName == "croire" then null
     else if config.networking.hostName == "croire-low" then "198769D1B0D0DF8C"
     else null;
     };
  */
}
