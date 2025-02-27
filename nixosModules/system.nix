{ inputs, ... }@flakeContext:
{ config
, lib
, pkgs
, ...
}:
{
  config = {
    console = {
      enable = true;
      font = "Monaspace Neon";
      keyMap = "us";
      packages = with pkgs; [
        #(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
        #nerdfonts
        nerd-fonts.fira-code
        borg-sans-mono # DroidSansMono
        monaspace
      ];
    };
    environment = {
      systemPackages = [
        pkgs.libusb1
        pkgs.wally-cli
        pkgs.zsa-udev-rules
        pkgs.qmk
        pkgs.gtk3
        pkgs.webkitgtk_6_0
        pkgs.libuuid
        pkgs.wineWowPackages.stable
        pkgs.wine
        (pkgs.wine.override { wineBuild = "wine64"; })
        pkgs.wine64
        pkgs.wineWowPackages.staging
        pkgs.winetricks
        pkgs.nix-ld
        pkgs.evince
        pkgs.foliate
        pkgs.pulseaudioFull
        pkgs.avizo
        pkgs.libnotify
        pkgs.fuzzel
      ];
    };
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        fira-code
        fira-code-symbols
        monaspace
      ];
      fontDir = {
        enable = true;
      };
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Monaspace Neon"
          ];
        };
        enable = true;
      };
    };
    hardware = {
      keyboard = {
        qmk = {
          enable = true;
        };
        zsa = {
          enable = true;
        };
      };
      nvidia = {
        open = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        modesetting = {
          enable = true;
        };
        # nvidiaSettings = true;

        package = lib.mkOptionDefault config.boot.kernelPackages.nvidiaPackages.production;
      };
      graphics = {
        enable = true;
        # driSupport32Bit = true;
        # driSupport64Bit = true;
        # driSupportPackages = with pkgs; [
        #   libGL
        #   libGLU
        #   libGLX
        #   libEGL
        #   libGLES
        #   libGLESv1_CM
        #   libGLESv2
        # ];
      };
    };
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LANGUAGE = "en_US.UTF-8";
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_COLLATE = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MESSAGES = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "nl_NL.UTF-8/UTF-8"
        "nl_NL/ISO-8859-1"
      ];
    };
    nix = {
      channel = {
        enable = true;
      };
    };
    programs = {
      nano = {
        enable = false;
      };
      nix-ld = {
        enable = true;
      };
    };
    services = {
      udev = {
        enable = true;
      };
      fstrim = {
        enable = true;
        interval = "weekly";
      };
    };
    system = {
      switch = {
        enable = true;
      };
    };
    time = {
      timeZone = "Europe/Amsterdam";
    };
    users = {
      groups = {
        plugdev = { };
      };
      mutableUsers = true;
      users = {
        saberzero1 = {
          expires = null;
          isNormalUser = true;
          useDefaultShell = true;
        };
      };
    };
    zramSwap = {
      enable = true;
      memoryPercent = 50;
      algorithm = "zstd";
    };
  };
}
