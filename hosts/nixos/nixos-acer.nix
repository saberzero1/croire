# Host: nixos-acer (NixOS laptop)
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
      luks.devices."luks-32b0cce0-aa62-475b-ab71-4fb3a3d7c980" = {
        device = "/dev/disk/by-uuid/32b0cce0-aa62-475b-ab71-4fb3a3d7c980";
      };
      systemd.enable = true;
    };
    kernelModules = [
      "kvm-amd"
      "nvidia_uvm"
    ];
    kernelParams = [ "usbcore.autosuspend=-1" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
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

  swapDevices = [ ];

  hardware = {
    enableRedistributableFirmware = true;
    alsa.enablePersistence = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = true;
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
        allowExternalGpu = true;
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:65:0:0";
      };
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
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
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
    hostName = "nixos-acer";
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
    systemd-vconsole-setup.after = [ "local-fs.target" ];
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

  nix.settings = {
    experimental-features = "nix-command flakes";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
    trusted-users = [
      "root"
      "saberzero1"
    ];
  };

  determinateNix.customSettings.trusted-users = [
    "root"
    "saberzero1"
  ];

  system.stateVersion = "25.11";
  time.timeZone = lib.mkForce "Europe/Amsterdam";
}
