{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    console = {
      enable = true;
    };
    environment = {
      systemPackages = [
        pkgs.libusb
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
    programs = {
      nano = {
        enable = false;
      };
    };
    services = {
      udev = {
        enable = true;
        extraRules = ''
          '''
          # Rules for Oryx web flashing and live training
          KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
          KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

          # Legacy rules for live training over webusb (Not needed for firmware v21+)
            # Rule for all ZSA keyboards
            SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
            # Rule for the Moonlander
            SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
            # Rule for the Ergodox EZ
            SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
            # Rule for the Planck EZ
            SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

          # Wally Flashing rules for the Ergodox EZ
          ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
          ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
          KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

          # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
          # Keymapp Flashing rules for the Voyager
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
          '''
        '';
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
