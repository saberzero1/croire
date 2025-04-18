{ flake
, pkgs
, lib
, ...
}:
{
  home = {
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
    sessionPath = [
      "/snap/bin"
    ];
    file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
      "export MOZ_ENABLE_WAYLAND=1"
      "export NIXOS_OZONE_WL=1"
    ];
  };
  dconf = {
    settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///home/saberzero1/.assets/backgroounds/wallpaper.png";
        picture-uri-dark = "file:///home/saberzero1/.assets/backgrounds/wallpaper.png";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "ranger.desktop"
          "wavebox.desktop"
          "obsidian.desktop"
          "discord.desktop"
          "nvim.desktop"
        ];
      };
    };
  };
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "wavebox.desktop" ];
        "x-scheme-handler/http" = [ "wavebox.desktop" ];
        "x-scheme-handler/https" = [ "wavebox.desktop" ];
        "x-scheme-handler/ftp" = [ "wavebox.desktop" ];
        "x-scheme-handler/chrome" = [ "wavebox.desktop" ];
        "x-scheme-handler/about" = [ "wavebox.desktop" ];
        "x-scheme-handler/unknown" = [ "wavebox.desktop" ];
        "application/x-extension-htm" = [ "wavebox.desktop" ];
        "application/x-extension-html" = [ "wavebox.desktop" ];
        "application/x-extension-shtml" = [ "wavebox.desktop" ];
        "application/xhtml+xml" = [ "wavebox.desktop" ];
        "application/x-extension-xhtml" = [ "wavebox.desktop" ];
        "application/x-extension-xht" = [ "wavebox.desktop" ];
      };
      associations.added = {
        "text/html" = [ "wavebox.desktop" ];
        "x-scheme-handler/http" = [ "wavebox.desktop" ];
        "x-scheme-handler/https" = [ "wavebox.desktop" ];
        "x-scheme-handler/ftp" = [ "wavebox.desktop" ];
        "x-scheme-handler/chrome" = [ "wavebox.desktop" ];
        "x-scheme-handler/about" = [ "wavebox.desktop" ];
        "x-scheme-handler/unknown" = [ "wavebox.desktop" ];
        "application/x-extension-htm" = [ "wavebox.desktop" ];
        "application/x-extension-html" = [ "wavebox.desktop" ];
        "application/x-extension-shtml" = [ "wavebox.desktop" ];
        "application/xhtml+xml" = [ "wavebox.desktop" ];
        "application/x-extension-xhtml" = [ "wavebox.desktop" ];
        "application/x-extension-xht" = [ "wavebox.desktop" ];
      };
    };
    configFile = {
      "mimeapps.list".force = true;
      "paperwm/user.css" = {
        source = "${flake.inputs.dotfiles}/paperwm/user.css";
      };
      "paperwm/user.js" = {
        source = "${flake.inputs.dotfiles}/paperwm/user.js";
      };
      "sway-interactive-screenshot/config.toml" = {
        source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/config.toml";
      };
      "sway-interactive-screenshot/sway-interactive-screenshot" = {
        source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/sway-interactive-screenshot";
      };
      ".assets/backgrounds" = {
        source = "${flake.inputs.dotfiles}/assets";
        recursive = true;
      };
    };
    desktopEntries = {
      "nvim" = {
        name = "nvim";
        comment = "Edit text files";
        icon = "nvim";
        exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.neovim}/bin/nvim %F";
        categories = [ "Application" ];
        terminal = false;
        mimeType = [ "text/plain" ];
      };
      "explorer" = {
        name = "explorer";
        comment = "TUI File Explorer";
        icon = "ranger";
        exec = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.ranger}/bin/ranger %F";
        categories = [ "Application" ];
        terminal = false;
        #mimeType = [ "text/plain" ];
      };
      "geforce-now" = {
        name = "GeForce NOW";
        comment = "Cloud Gaming";
        icon = "geforcenow-electron";
        exec = "/snap/bin/geforcenow-electron";
        categories = [ "Application" ];
        terminal = false;
        #mimeType = [ "text/plain" ];
      };
    };
  };

  wayland = {
    systemd = {
      # target = "sway-session.target";
    };

    windowManager.sway = {
      enable = true;
      xwayland = true;
      checkConfig = true;
      systemd.xdgAutostart = true;
      wrapperFeatures = {
        gtk = true;
      };

      config = rec {
        modifier = "Mod4";
        input = {
          "*" = {
            xkb_layout = "us";
          };
          "12951:6505:ZSA_Technology_Labs_Moonlander_Mark_I" = {
            xkb_layout = "us";
          };
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            middle_emulation = "enabled";
          };
        };
        output = {
          "*" = {
            bg = "${flake.inputs.dotfiles}/assets/wallpaper_night.png fill";
          };
        };
        terminal = "${pkgs.wezterm}/bin/wezterm";
        keybindings =
          let
            mod = "Mod4+Mod1";
            mod2 = "Mod4+Mod1+Ctrl";
            left = "h";
            down = "j";
            up = "k";
            right = "l";
          in
          lib.mkOptionDefault {
            "${mod}+q" = "kill";
            "${mod}+c" = "reload";
            "Print" = "exec ${flake.inputs.dotfiles}/sway-interactive-screenshot/sway-interactive-screenshot";
            "Shift+Print" =
              "exec ${flake.inputs.dotfiles}/sway-interactive-screenshot/sway-interactive-screenshot --video";
            "${mod}+${left}" = "focus left";
            "${mod}+${down}" = "focus down";
            "${mod}+${up}" = "focus up";
            "${mod}+${right}" = "focus right";
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";
            "${mod2}+${left}" = "move left";
            "${mod2}+${down}" = "move down";
            "${mod2}+${up}" = "move up";
            "${mod2}+${right}" = "move right";
            "${mod2}+Left" = "move left";
            "${mod2}+Down" = "move down";
            "${mod2}+Up" = "move up";
            "${mod2}+Right" = "move right";
            "${mod}+1" = "workspace number 1";
            "${mod}+2" = "workspace number 2";
            "${mod}+3" = "workspace number 3";
            "${mod}+4" = "workspace number 4";
            "${mod}+5" = "workspace number 5";
            "${mod}+6" = "workspace number 6";
            "${mod}+7" = "workspace number 7";
            "${mod}+8" = "workspace number 8";
            "${mod}+9" = "workspace number 9";
            "${mod}+0" = "workspace number 10";
            "${mod2}+1" = "move container to workspace number 1";
            "${mod2}+2" = "move container to workspace number 2";
            "${mod2}+3" = "move container to workspace number 3";
            "${mod2}+4" = "move container to workspace number 4";
            "${mod2}+5" = "move container to workspace number 5";
            "${mod2}+6" = "move container to workspace number 6";
            "${mod2}+7" = "move container to workspace number 7";
            "${mod2}+8" = "move container to workspace number 8";
            "${mod2}+9" = "move container to workspace number 9";
            "${mod2}+0" = "move container to workspace number 10";
            "XF86MonBrightnessUp" = "exec lightctl up";
            "XF86MonBrightnessDown" = "exec lightctl down";
            "XF86AudioRaiseVolume" = "exec volumectl -u up";
            "XF86AudioLowerVolume" = "exec volumectl -u down";
            "XF86AudioMute" = "exec volumectl toggle-mute";
            "XF86AudioMicMute" = "exec volumectl -m toggle-mute";
            "${mod}+g" = "exec wl-copy \"\"";
            "${mod}+Minus" = "splitv";
            "${mod}+Backslash" = "splith";
            "${mod}+f" = "fullscreen";
            "${mod2}+space" = "floating toggle";
            "${mod}+o" = "exec wofi &";
            "${mod2}+o" = "exec wofi &";
            "Mod4+l" =
              "exec swaylock  -i ${flake.inputs.dotfiles}/assets/wallpaper_night_blurred.png --indicator-radius 100 --indicator-thickness 7 --hide-keyboard-layout --disable-caps-lock-text --ignore-empty-password --ring-color b4f9f8 --key-hl-color c0caf5 --line-color 00000000 --inside-color b4f9f888 --separator-color 00000000 --ring-wrong-color f7768e --line-wrong-color 00000000 --inside-wrong-color f7768e88 --text-wrong-color 00000000 --ring-ver-color 7aa2f7 --line-ver-color 00000000 --inside-ver-color 7aa2f788 --text-ver-color 00000000 --ring-clear-color 565f89 --line-clear-color 00000000 --inside-clear-color 565f8988 --text-clear-color 00000000 --ring-caps-lock-color e0af68 --line-caps-lock-color 00000000 --inside-caps-lock-color e0af6888 --text-caps-lock-color 00000000";
          };

        startup = [
          { command = "systemctl --user import-environment"; }
          { command = "avizo-service"; }
          { command = "wezterm"; }
          { command = "configure-gtk"; }
          { command = "dbus-sway-environment"; }
        ];

        bars = [ ];

        defaultWorkspace = "workspace number 1";
      };

      extraConfig = ''
        client.focused          #7aa2f7 #414868 #c0caf5 #7dcfff   #7aa2f7
        client.focused_inactive #7aa2f7 #414868 #c0caf5 #7dcfff   #7aa2f7
        client.unfocused        #414868 #24283b #a9b1d6 #7dcfff   #414868
        client.urgent           #e0af68 #e0af68 #1d202f #7dcfff   #e0af68

        client.background       #ffffff

        default_border pixel 1

        assign [app_id="ghostty"] workspace number 1
        assign [app_id="wezterm"] workspace number 1
        assign [app_id="discord"] workspace number 2
        assign [app_id="wavebox"] workspace number 3 
        assign [app_id="zen"] workspace number 3
        assign [app_id="zed"] workspace number 4
        assign [app_id="codium-url-handler"] workspace number 4
        assign [app_id="wine"] workspace number 4

        for_window [app_id="com.github.finefindus.eyedropper"] floating enable

        include @sysconfdir@/sway/config.d/*
      '';

      extraSessionCommands = ''
        eval "$(ssh-agent -s)"
        eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
        export SSH_AUTH_SOCK
      '';

    };
  };

}
