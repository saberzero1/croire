{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    console = {
      enable = true;
    };
    environment = {
      systemPackages = [
        pkgs.libusb
        pkgs.wally-cli
        pkgs.zsa-udev-rules
      ];
    };
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      fontDir = {
        enable = true;
      };
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Fira Code"
          ];
        };
        enable = true;
      };
    };
    hardware = {
      keyboard = {
        zsa = {
          enable = true;
        };
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
    nixpkgs = {
      overlays = [
        (super: self: {
          zsa-udev-rules = super.zsa-udev-rules.overrideAttrs (final: prev: {
            version = "2.1.3";
            src = self.fetchFromGitHub {
              owner = "zsa";
              repo = "wally";
              rev = "623a50d0e0b90486e42ad8ad42b0a7313f7a37b3";
              sha256 = "sha256-meR2V7T4hrJFXFPLENHoAgmOILxxynDBk0BLqzsAZvQ=";
            };
          });
        })
      ];
    };
    programs = {
      nano = {
        enable = false;
      };
    };
    services = {
      udev = {
        enable = true;
      };
    };
    system = {
      switch = {
        enable = true;
      };
    };
    time = {
      timeZone = "Europe/Brussels";
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
  };
}
