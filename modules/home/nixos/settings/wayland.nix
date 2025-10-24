{ flake
, pkgs
, lib
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  wayland = {
    windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
      };
      settings = {
        monitor = ",preferred,auto,1";

        exec-once = [
          "hyprlock || hyperctl dispatch exit"
          "systemctl --user import-environment"
          "hyprpaper"
          "avizo-service"
          # "waybar"
          "mako"
          "eval $(ssh-agent -s)"
          "eval $(/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = false;
          };
          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 1;
          "col.active_border" = "rgba(7aa2f7ee)";
          "col.inactive_border" = "rgba(414868aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 5;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          # drop_shadow = true;
          # shadow_range = 4;
          # shadow_render_power = 3;
          # "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        # gestures = {
        #   workspace_swipe = false;
        # };

        misc = {
          force_default_wallpaper = 0;
        };

        # Window rules
        windowrulev2 = [
          "workspace 1, class:^(ghostty)$"
          "workspace 1, class:^(wezterm)$"
          "workspace 2, class:^(obsidian)$"
          "workspace 3, class:^(zen)$"
          "workspace 4, class:^(zed)$"
          "workspace 4, class:^(codium-url-handler)$"
          "workspace 4, class:^(wine)$"
          "workspace 5, class:^(discord)$"
          "float, class:^(com.github.finefindus.eyedropper)$"
        ];

        # Keybindings
        "$mod" = "SUPER_ALT";
        "$mod2" = "SUPER_ALT_CTRL";

        bind = [
          # Applications
          "$mod, t, exec, ghostty"
          "$mod, g, exec, ghostty"
          "$mod, n, exec, obsidian"
          "$mod, w, exec, zen"
          "$mod, z, exec, zed"
          "$mod, d, exec, discord"

          # Window management
          "$mod, q, killactive,"
          "$mod, c, exec, hyprctl reload"
          "$mod, f, fullscreen,"
          "$mod2, space, togglefloating,"

          # Launcher
          "$mod, o, exec, wofi --show drun"
          "$mod2, o, exec, wofi --show drun"

          # Screenshots
          ", Print, exec, grimblast copy area"
          "SHIFT, Print, exec, grimblast save area ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d-%H%M%S.png')"

          # Lock screen
          "SUPER, l, exec, hyprlock"

          # Focus movement
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Window movement
          "$mod2, h, movewindow, l"
          "$mod2, l, movewindow, r"
          "$mod2, k, movewindow, u"
          "$mod2, j, movewindow, d"
          "$mod2, left, movewindow, l"
          "$mod2, right, movewindow, r"
          "$mod2, up, movewindow, u"
          "$mod2, down, movewindow, d"

          # Workspace switching
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move to workspace
          "$mod2, 1, movetoworkspace, 1"
          "$mod2, 2, movetoworkspace, 2"
          "$mod2, 3, movetoworkspace, 3"
          "$mod2, 4, movetoworkspace, 4"
          "$mod2, 5, movetoworkspace, 5"
          "$mod2, 6, movetoworkspace, 6"
          "$mod2, 7, movetoworkspace, 7"
          "$mod2, 8, movetoworkspace, 8"
          "$mod2, 9, movetoworkspace, 9"
          "$mod2, 0, movetoworkspace, 10"

          # Splitting
          "$mod, minus, layoutmsg, splitv"
          "$mod, backslash, layoutmsg, splith"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        binde = [
          # Media keys
          ", XF86MonBrightnessUp, exec, lightctl up"
          ", XF86MonBrightnessDown, exec, lightctl down"
          ", XF86AudioRaiseVolume, exec, volumectl -u up"
          ", XF86AudioLowerVolume, exec, volumectl -u down"
          ", XF86AudioMute, exec, volumectl toggle-mute"
          ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
        ];
      };

      # Extra configuration for submap bindings
      extraConfig = ''
        # Resize submap
        bind = $mod, r, submap, resize

        # Bindings that only work in resize submap
        submap = resize
        bind = , h, resizeactive, -10 0
        bind = , l, resizeactive, 10 0
        bind = , k, resizeactive, 0 -10
        bind = , j, resizeactive, 0 10
        bind = , left, resizeactive, -10 0
        bind = , right, resizeactive, 10 0
        bind = , up, resizeactive, 0 -10
        bind = , down, resizeactive, 0 10
        bind = , escape, submap, reset
        bind = , return, submap, reset
        submap = reset
      '';
    };
  };
}
