{ pkgs, config, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      vlc
      steam
      obsidian
      discord
      nexusmods-app
      steamtinkerlaunch
      wofi
      wofi-pass
      gdm
      gnome-shell
      gnome-shell-extensions
      gnome-browser-connector
      gnomeExtensions.burn-my-windows
      gnomeExtensions.app-icons-taskbar
      gnomeExtensions.espresso
      gnomeExtensions.memento-mori
      gnomeExtensions.paperwm
      gnome-remote-desktop
      nautilus
      nautilus-python
      nautilus-open-any-terminal
      xrdp
      freerdp
      albert
      wlsunset
      uwsm
      mako
      sway

      ghostty
      # gitbutler

      libusb1
      wally-cli
      zsa-udev-rules
      qmk
      gtk3
      webkitgtk_6_0
      libuuid
      wineWowPackages.stable
      wine
      (pkgs.wine.override { wineBuild = "wine64"; })
      wine64
      wineWowPackages.staging
      winetricks
      nix-ld
      evince
      foliate
      pulseaudioFull
      avizo
      libnotify
      fuzzel

      gnugrep
      gnused
      glib
      glibc
      nss
      libnss_nis
      curlFull
      iwgtk
      iperf2
      sshpass
      uget
      wget2
      gnumake
      _7zz
      parallel

      vscodium.fhs
      vscode-extensions.asvetliakov.vscode-neovim
    ];
    # Most of these are optional programs added by services.gnome.core-services
    # and etc., but the module sets other useful options so it is better to
    # exclude these instead of disabling the module.
    gnome = {
      excludePackages = [
        pkgs.baobab # disk usage analyzer
        # epiphany # web browser
        pkgs.geary # e-mail client
        pkgs.gnome-backgrounds
        pkgs.gnome-bluetooth
        pkgs.gnome-characters
        pkgs.gnome-clocks
        pkgs.gnome-color-manager
        pkgs.gnome-contacts
        pkgs.gnome-font-viewer
        pkgs.gnome-logs
        pkgs.gnome-music
        pkgs.gnome-system-monitor
        pkgs.gnome-themes-extra
        pkgs.glib
        # pkgs.gnome-connections
        pkgs.gnome-photos
        pkgs.gnome-text-editor
        pkgs.gnome-tour
        pkgs.gnome-user-docs
        pkgs.orca # screen reader
        pkgs.simple-scan
        pkgs.totem # video player
        pkgs.yelp # help viewer
      ];
    };
  };

  console = {
    enable = true;
    font = "Monaspace Neon";
    keyMap = "us";
  };

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "wavebox.desktop" ];
        "x-scheme-handler/http" = [ "wavebox.desktop" ];
        "x-scheme-handler/https" = [ "wavebox.desktop" ];
        "x-scheme-handler/ftp" = [ "wavebox.desktop" ];
        "x-scheme-handler/chrome" = [ "wavebox.desktop" ];
        "x-scheme-handler/about" = [ "wavebox.desktop" ];
        "x-scheme-handler/unknown" = [ "wavebox.desktop" ];
        "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
        "application/x-extension-htm" = [ "wavebox.desktop" ];
        "application/x-extension-html" = [ "wavebox.desktop" ];
        "application/x-extension-shtml" = [ "wavebox.desktop" ];
        "application/xhtml+xml" = [ "wavebox.desktop" ];
        "application/x-extension-xhtml" = [ "wavebox.desktop" ];
        "application/x-extension-xht" = [ "wavebox.desktop" ];
      };
    };
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      extraPackages = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };

  systemd = {
    user = {
      tmpfiles = {
        rules = [ ];
      };

      services.rCloneMounts = {
        description = "Mount all rClone configurations";
        after = [ "network-online.target" ];
        serviceConfig = {
          Type = "forking";
          ExecStartPre = "${pkgs.writeShellScript "rClonePre" ''
            remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
            for remote in $remotes;
            do
            name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
            /usr/bin/env mkdir -p $HOME/"$name"
            done
          ''}";
          ExecStart = "${pkgs.writeShellScript "rCloneStart" ''
            remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
            for remote in $remotes;
            do
            name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
            ${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount "$remote" "$name" &
            done
          ''}";
          ExecStop = "${pkgs.writeShellScript "rCloneStop" ''
            remotes=$(${pkgs.rclone}/bin/rclone --config=$HOME/.config/rclone/rclone.conf listremotes)
            for remote in $remotes;
            do
            name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
            /usr/bin/env fusermount -u $HOME/"$name"
            done
          ''}";
        };
        wantedBy = [ "default.target" ];
      };

    };

  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  powerManagement = {
    cpuFreqGovernor = "performance";
  };

  appstream = {
    enable = true;
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
      # package = config.boot.kernelPackages.nvidiaPackages.production;
    };
    graphics = {
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
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  nix = {
    channel = {
      enable = true;
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

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  programs = {
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "wezterm";
    };

    dbus = {
      enable = true;
    };

    sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
      xwayland.enable = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        wf-recorder
        sway-contrib.grimshot
        mako # notification daemon
        grim
        slurp
        alacritty # Alacritty is the default terminal in the config
        dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
        wofi
        gtk-engine-murrine
        gtk_engines
        gsettings-desktop-schemas
        lxappearance
        kdePackages.dragon
        swappy
        xdg-utils
      ];

      extraOptions = [
        "--verbose"
        "--debug"
        "--unsupported-gpu"
      ];

      extraSessionCommands = ''
        eval "$(ssh-agent -s)"
        eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
        export SSH_AUTH_SOCK
      '';
    };

    waybar = {
      enable = true;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        sway = {
          prettyName = "Sway";
          comment = "Sway compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/sway";
        };
      };
    };

    wayland = {
      enable = true;
      windowManager.sway = {
        enable = true;
      };
    };

    nano = {
      enable = false;
    };

    nix-ld = {
      enable = true;
    };

    npm = {
      enable = true;
      npmrc = ''
        '''
          prefix = '''''${HOME}/.npm
          color=true
        '''
      '';
    };

    steam = {
      enable = true;
      package = pkgs.steam;
      protontricks = {
        enable = true;
        package = pkgs.protontricks;
      };
    };
  };
}
