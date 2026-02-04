# Dendritic feature module: Home services configuration
# Provides unified home services across platforms (Darwin, NixOS)
# Includes: espanso (text expansion), emacs daemon, mako (notifications), wlsunset (screen temp)
# Exports: homeModules.services
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.services =
    {
      flake,
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    {
      # ===========================================
      # Cross-platform Services
      # ===========================================

      services = {
        # Emacs daemon (cross-platform, currently disabled)
        emacs.enable = false;

        # Espanso - text expansion
        # On macOS, espanso is installed via Homebrew to maintain stable accessibility permissions.
        # Nix-installed binaries have changing hashes that cause macOS to revoke permissions on rebuild.
        # See: https://github.com/nix-community/home-manager/issues/8179
        espanso = lib.mkIf isLinux {
          enable = true;
          package = pkgs.espanso;
          package-wayland = pkgs.espanso-wayland;
          waylandSupport = true;
          x11Support = true;
        };

        # ===========================================
        # Linux-only Services
        # ===========================================

        # Mako - notification daemon (Wayland)
        mako = lib.mkIf isLinux {
          enable = true;
        };

        # Wlsunset - automatic color temperature adjustment (Wayland)
        wlsunset = lib.mkIf isLinux {
          enable = true;
          package = pkgs.wlsunset;
          sunrise = "08:00";
          sunset = "18:00";
          temperature = {
            day = 6500;
            night = 4000;
          };
        };

        # ===========================================
        # Darwin-only Services
        # ===========================================

        # SKHD - hotkey daemon (disabled, using aerospace instead)
        skhd = lib.mkIf isDarwin {
          enable = false;
          package = pkgs.skhd;
          config = ''
            # Close current window
            cmd + alt - q: skhd -k "cmd - q "
            cmd + alt + ctrl - q: kill $(yabai -m query --windows --window | jq pid)

            # Open launcher
            cmd + alt - o: open -a /Applications/Sol.app/Contents/MacOS/sol

            # Open specific applications
            cmd + alt - t: open -a Wezterm
            cmd + alt - n: open -a Obsidian
            cmd + alt - b: open -a Wavebox

            # Window focus
            cmd + alt - h: yabai -m window --focus west
            cmd + alt - j: yabai -m window --focus south
            cmd + alt - k: yabai -m window --focus north
            cmd + alt - l: yabai -m window --focus east

            # Window movement
            cmd + alt + ctrl - h: yabai -m window --swap west
            cmd + alt + ctrl - j: yabai -m window --swap south
            cmd + alt + ctrl - k: yabai -m window --swap north
            cmd + alt + ctrl - l: yabai -m window --swap east

            # Fullscreen
            cmd + alt - f: yabai -m window --toggle zoom-fullscreen

            # Restart yabai
            cmd + alt - r: yabai --service-stop; yabai --service-start

            # Move focus
            cmd + alt - 1: yabai -m space --focus 1
            cmd + alt - 2: yabai -m space --focus 2
            cmd + alt - 3: yabai -m space --focus 3
            cmd + alt - 4: yabai -m space --focus 4
            cmd + alt - 5: yabai -m space --focus 5
            cmd + alt - 6: yabai -m space --focus 6
            cmd + alt - 7: yabai -m space --focus 7
            cmd + alt - 8: yabai -m space --focus 8
            cmd + alt - 9: yabai -m space --focus 9
            cmd + alt - 0: yabai -m space --focus 10

            # Move windows
            cmd + alt + ctrl - 1: yabai -m window --space 1
            cmd + alt + ctrl - 2: yabai -m window --space 2
            cmd + alt + ctrl - 3: yabai -m window --space 3
            cmd + alt + ctrl - 4: yabai -m window --space 4
            cmd + alt + ctrl - 5: yabai -m window --space 5
            cmd + alt + ctrl - 6: yabai -m window --space 6
            cmd + alt + ctrl - 7: yabai -m window --space 7
            cmd + alt + ctrl - 8: yabai -m window --space 8
            cmd + alt + ctrl - 9: yabai -m window --space 9
            cmd + alt + ctrl - 0: yabai -m window --space 10
          '';
        };
      };

      # ===========================================
      # Service Configuration Files
      # ===========================================
      home.file = {
        # Espanso text expansion config (from totten flake input)
        espanso = {
          target = ".config/espanso";
          source = "${flake.inputs.totten}";
          recursive = true;
        };

        # ───────────────────────────────────────────────────────────────────────
        # Darwin-only service files
        # ───────────────────────────────────────────────────────────────────────

        # SKHD scripts (executables)
        "skhd-kill-last-instance" = lib.mkIf isDarwin {
          target = ".config/skhd/scripts/kill_last_instance.sh";
          source = "${self}/programs/skhd/scripts/kill_last_instance.sh";
          executable = true;
        };

        # Yabai config (executable)
        yabairc = lib.mkIf isDarwin {
          target = ".config/yabai/yabairc";
          source = "${self}/programs/yabai/yabairc";
          executable = true;
        };

        # ───────────────────────────────────────────────────────────────────────
        # Darwin Sketchybar Configuration Files
        # ───────────────────────────────────────────────────────────────────────
        sketchybarrc = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/sketchybarrc";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/sketchybarrc";
        };
        "sketchybar-aerospace" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/aerospace.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/aerospace.sh";
        };
        "sketchybar-battery" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/battery.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/battery.sh";
        };
        "sketchybar-clock" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/clock.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/clock.sh";
        };
        "sketchybar-cpu" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/cpu.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/cpu.sh";
        };
        "sketchybar-date" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/date.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/date.sh";
        };
        "sketchybar-front-app" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/front_app.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/front_app.sh";
        };
        "sketchybar-memory" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/memory.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/memory.sh";
        };
        "sketchybar-space" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/space.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/space.sh";
        };
        "sketchybar-volume" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/volume.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/volume.sh";
        };
        "sketchybar-wifi" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/sketchybar/plugins/wifi.sh";
          text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/wifi.sh";
        };
        "aerospace-finder-move" = lib.mkIf isDarwin {
          executable = true;
          target = ".config/aerospace/finder-move.sh";
          text = pkgs.lib.readFile "${self}/programs/aerospace/finder-move.sh";
        };
      };
    };
}
