# Host: nixos (NixOS desktop)
# Dendritic pattern: Host-specific configuration
{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.nix-snapd.nixosModules.default
    { services.snap.enable = false; }
  ];

  # The platform the configuration will be used on
  nixpkgs = {
    hostPlatform.system = "x86_64-linux";
    config = {
      allowUnfree = true;
      allowBroken = true;
      nvidia.acceptLicense = true;
      cudaSupport = true;
      packageOverrides = pkgs: {
        libsoup = pkgs.libsoup_3;
        libsoup_2_4 = pkgs.libsoup_3;
      };
    };
    overlays = lib.attrValues (self.overlays or { });
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
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "usbcore.autosuspend=-1" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
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

  swapDevices = [ { device = "/dev/disk/by-uuid/abb6997f-138e-42ad-a312-00c225b18520"; } ];

  hardware = {
    enableRedistributableFirmware = true;
    alsa.enablePersistence = true;

    nvidia = {
      open = false;
      modesetting.enable = true;
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
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    keyboard = {
      qmk.enable = true;
      zsa.enable = true;
    };
  };

  services = {
    pulseaudio.enable = false;
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
    dnscrypt-proxy = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };

  networking = {
    hostName = "nixos";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.extraConfig = "nohook resolv.conf";
    wireless = {
      allowAuxiliaryImperativeNetworks = true;
      dbusControlled = true;
    };
  };

  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  users = {
    groups.plugdev = { };
    mutableUsers = true;
    defaultUserShell = pkgs.nushell;
    users."saberzero1" = {
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

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
  time.timeZone = lib.mkForce "Europe/Amsterdam";
}
