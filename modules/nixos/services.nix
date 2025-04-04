{ pkgs
, lib
, config
, ...
}:
{
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

    udev = {
      enable = true;
      path = [
        "${pkgs.coreutils-full}/bin"
      ];
      # Disable autosuspend on all USB keyboards and mice
      # extraRules = ''
      #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
      #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/autosuspend", ATTR{power/autosuspend}="0"
      #   ACTION=="add", SUBSYSTEM=="usb", TEST=="power/autosuspend_delay_ms", ATTR{power/autosuspend_delay_ms}="0"
      # '';
    };

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    printing = {
      enable = false;
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "saberzero1";
      };
    };

    flatpak = {
      enable = true;
    };

    xserver = {
      enable = true;
      desktopManager = {
        gnome = {
          enable = true;
        };
        wallpaper = {
          combineScreens = false;
          mode = "fill";
        };
      };
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
        sessionCommands = ''
          ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        '';
      };
      videoDrivers = [
        # "nvidia"
        "nouveau"
      ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager = {
      defaultSession = "sway";
    };

    xrdp = {
      enable = false;
      defaultWindowManager = "gnome-remote-desktop";
      openFirewall = false;
      port = 3389;
    };

    gnome = {
      gnome-browser-connector = {
        enable = true;
      };
      gnome-keyring = {
        enable = true;
      };
    };

    openssh = {
      enable = true;
    };

    # Backups and Restores
    prometheus = {
      enable = false;
      exporters = {
        restic = {
          enable = false;
          port = 9753;
          rcloneConfigFile = "${config.home.homeDirectory}/.config/rclone/.rclone.conf";
        };
      };
    };

    restic = {
      server = {
        enable = false;
        prometheus = true;
      };
    };

    # Yubikey
    yubikey-agent = {
      enable = false;
    };
  };
}
