# Dendritic feature module: Shell configuration
# Provides unified shell configuration across all platforms (Darwin, NixOS)
# Exports: homeModules.shell (includes zsh, nushell, starship)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.shell =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;

      # ─────────────────────────────────────────────────────────────────────────
      # Shell-specific scripts (bash syntax incompatible with nushell)
      # ─────────────────────────────────────────────────────────────────────────
      shellScripts = [
        (pkgs.writeShellScriptBin "gj" ''
          # Global justfile choose (with stderr suppression)
          ${pkgs.just}/bin/just --global-justfile --choose 2>/dev/null
        '')
        (pkgs.writeShellScriptBin "disk" ''
          # Show disk usage
          df -H --output=pcent,avail,target | grep \/$ | sed "s# \/##" | sed "s#% *#%#g" | sed "s#^#Disk usage:#" | sed "s#%#% (#" | sed "s#\$# available)#"
        '')
        (pkgs.writeShellScriptBin "path" ''
          # Print PATH variable separated by newlines
          echo "''${PATH//:/\\n}"
        '')
        (pkgs.writeShellScriptBin "reload" ''
          # Reload shell
          exec "$SHELL" -l
        '')
        (pkgs.writeShellScriptBin "nixfu" ''
          # Nix flake update with GitHub token
          nix flake update --option access-tokens "github.com=$(${pkgs.gh}/bin/gh auth token)"
        '')
        (pkgs.writeShellScriptBin "now" ''
          # Date and time
          date '+%Y-%m-%d %A %T %Z'
        '')
        (pkgs.writeShellScriptBin "week" ''
          # Get current week number
          date +%V
        '')
        (pkgs.writeShellScriptBin "weather" ''
          # Get weather in a short format
          curl -s 'wttr.in/?format=3'
        '')
        (pkgs.writeShellScriptBin "t" ''
          # List files in tree format (alias for tree command)
          ${pkgs.tree}/bin/tree --dirsfirst "$@"
        '')
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Shell aliases (cross-shell compatible)
      # ─────────────────────────────────────────────────────────────────────────
      cdAliases = {
        "-" = "cd -";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
        "......." = "cd ../../../../../..";
        "........" = "cd ../../../../../../..";
        "........." = "cd ../../../../../../../..";
        ".........." = "cd ../../../../../../../../..";
        "..........." = "cd ../../../../../../../../../..";
        "~" = "cd ~";
      };

      gitAliases = {
        g = "git";
        ga = "git add";
        gaa = "git add --all";
        gb = "git branch";
        gco = "git checkout";
        gcm = "git commit -m";
        gca = "git commit --amend --no-edit";
        gcma = "git commit --amend";
        gd = "git diff";
        gdc = "git diff --cached";
        gf = "git fetch";
        gfa = "git fetch --all";
        gl = "git log --oneline --reverse --graph --decorate --all";
        gp = "git pull";
        gpa = "git pull --all";
        gpu = "git push";
        gs = "git status";
      };

      justAliases = {
        j = "${pkgs.just}/bin/just --choose";
        jj = "${pkgs.just}/bin/just --global-justfile";
      };

      lsAliases = {
        ls = "${pkgs.eza}/bin/eza --icons --long --group-directories-first";
        lsa = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first";
        lsd = "${pkgs.eza}/bin/eza --icons --long --group-directories-first --tree";
        lsae = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first --tree";
        ll = "${pkgs.eza}/bin/eza --icons --long";
        la = "${pkgs.eza}/bin/eza --icons --long --all";
        lld = "${pkgs.eza}/bin/eza --icons --long --tree";
        lae = "${pkgs.eza}/bin/eza --icons --long --all --tree";
      };

      nixAliases = {
        nixf = "nix flake";
      };

      npmAliases = {
        npb = "npm build";
        npc = "npm cache";
        npd = "npm dev";
        npg = "npm global";
        npi = "npm install";
        npl = "npm list";
        npp = "npm publish";
        npr = "npm run";
        nprw = "npm run watch";
        nps = "npm start";
        npsv = "npm serve";
        npt = "npm test";
        npu = "npm update";
        npy = "npm why";
      };

      utilityAliases = {
        ports = "sudo lsof -i -P";
        p = "pwd";
        ts = "tmux-sessionizer";
      };

      viAliases = {
        vi = "${pkgs.neovim}/bin/nvim";
        vim = "${pkgs.neovim}/bin/nvim";
        vimdiff = "${pkgs.neovim}/bin/nvim -d";
      };

      yaziAliases = {
        y = "${pkgs.yazi}/bin/yazi";
      };

      # Platform-specific aliases
      darwinAliases = lib.optionalAttrs isDarwin {
        "reload-rclone" = "launchctl kickstart -k gui/$(id -u)/rCloneMounts.service";
      };

      linuxAliases = lib.optionalAttrs isLinux {
        "power-down" = "shutdown --poweroff --no-wall 0";
      };

      allAliases =
        cdAliases
        // gitAliases
        // justAliases
        // lsAliases
        // nixAliases
        // npmAliases
        // utilityAliases
        // viAliases
        // yaziAliases
        // darwinAliases
        // linuxAliases;
    in
    {
      # ─────────────────────────────────────────────────────────────────────────
      # Session Configuration
      # ─────────────────────────────────────────────────────────────────────────
      home.sessionVariables = {
        # XDG Base Directory - required for nushell to find config on macOS
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
        XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
        # Editor settings
        EDITOR = "nvim";
        VISUAL = "nvim";
        LAZY = "${config.home.homeDirectory}/share/lazy-nvim";
        SHELL = "${pkgs.nushell}/bin/nu";
        # Just settings
        JUST_CHOOSER = "${pkgs.fzf}/bin/fzf";
        JUST_COLOR = "always";
        JUST_TIMESTAMP = "true";
        JUST_TIMESTAMP_FORMAT = "%Y-%m-%d %H:%M:%S";
        JUST_UNSTABLE = "true";
        # Tmux sessionizer settings
        TS_SEARCH_PATHS = "(~/Repos ~/Documents/Repos ~/Work/Repos ~/Work/External/Repos)";
        TS_MAX_DEPTH = "3";
      }
      // lib.optionalAttrs isDarwin {
        # Darwin-specific session variables
        HOMEBREW_AUTO_UPDATE_SEC = toString (60 * 60 * 24 * 7); # 1 week
        TS_EXTRA_SEARCH_PATHS = "(~/Work/Repos ~/Work/External/Repos)";
        SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      }
      // lib.optionalAttrs isLinux {
        # Linux-specific session variables (Wayland/Hyprland)
        TERM = "xterm-ghostty";
        DL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.libsForQt5.qt5.qtbase.bin}/lib/qt-${pkgs.libsForQt5.qt5.qtbase.version}/plugins";
        NIXOS_OZONE_WL = "1";
        LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.glib.out}/lib";
        TS_EXTRA_SEARCH_PATHS = "";
      };

      home.sessionPath = [
        "${config.home.homeDirectory}/.config/just"
        "${config.home.homeDirectory}/.config/tmux/scripts"
        "${config.home.homeDirectory}/.local/bin"
      ];

      # Cross-shell aliases
      home.shellAliases = allAliases;

      # Shell-specific script packages (platform-specific uuid script)
      home.packages =
        shellScripts
        ++ lib.optionals isDarwin [
          (pkgs.writeShellScriptBin "uuid" ''
            # Generate UUID, copy to clipboard (macOS), and print
            uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo
          '')
        ]
        ++ lib.optionals isLinux [
          (pkgs.writeShellScriptBin "uuid" ''
            # Generate UUID, copy to clipboard (Wayland), and print
            uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | ${pkgs.wl-clipboard}/bin/wl-copy -n && ${pkgs.wl-clipboard}/bin/wl-paste
          '')
        ];
      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # Zsh - Primary interactive shell
        # ─────────────────────────────────────────────────────────────────────────
        zsh = {
          enable = true;
          package = pkgs.zsh;
          dotDir = "${config.home.homeDirectory}/.config/zsh";
          autosuggestion.enable = true;
          enableCompletion = true;
          history.save = 100000;
          syntaxHighlighting.enable = true;
          enableVteIntegration = false;

          initContent = ''
            ${lib.optionalString isDarwin ''
              # Homebrew on macOS
              if [[ $(uname -m) == 'arm64' ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
              fi
            ''}

            ${lib.optionalString isLinux ''
              # Systemd environment on Linux
              eval $(dbus-update-activation-environment --systemd --all)
            ''}

            # Source custom shortcuts
            source "${config.home.homeDirectory}/.config/zsh/scripts/shortcuts"

            # direnv
            eval "$(direnv hook zsh)"

            # tmux sessionizer keybinding
            bindkey -s "^F" "tmux-sessionizer\n"
          '';

          plugins = [
            {
              name = "zsh-autopair";
              src = pkgs.zsh-autopair;
              file = "share/zsh-autopair/zsh-autopair.zsh";
            }
            {
              name = "zsh-autosuggestions";
              src = pkgs.zsh-autosuggestions;
              file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            }
            {
              name = "vi-mode";
              src = pkgs.zsh-vi-mode;
              file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
            {
              name = "zsh-you-should-use";
              src = pkgs.zsh-you-should-use;
              file = "share/zsh-you-should-use/zsh-vi-mode.plugin.zsh";
            }
          ];
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Nushell - Modern shell with structured data
        # ─────────────────────────────────────────────────────────────────────────
        nushell = {
          enable = true;

          settings = {
            show_banner = false;
            history = {
              max_size = 100000;
              sync_on_enter = true;
              file_format = "sqlite";
              isolation = false;
            };
            completions = {
              case_sensitive = false;
              quick = true;
              partial = true;
              algorithm = "fuzzy";
              sort = "smart";
              external = {
                enable = true;
                max_results = 100;
              };
            };
            buffer_editor = "nvim";
            edit_mode = "vi";
            cursor_shape = {
              emacs = "line";
              vi_insert = "line";
              vi_normal = "block";
            };
            recursion_limit = 50;
          };

          extraConfig = ''
            # Custom PATH additions
            $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.HOME | path join ".local/bin"))

            # Keybindings
            $env.config.keybindings = ($env.config.keybindings | append {
              name: tmux_sessionizer
              modifier: control
              keycode: char_f
              mode: [emacs vi_normal vi_insert]
              event: { send: executehostcommand cmd: "tmux-sessionizer" }
            })

            # Carapace completions
            source "~/.config/nushell/integration/carapace.nu"

            # Zoxide
            source "~/.config/nushell/integration/zoxide.nu"
          '';

          extraEnv = ''
            # Editor
            $env.EDITOR = "nvim"
            $env.VISUAL = "nvim"

            # XDG directories
            $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
            $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
            $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")

            # NU_LIB_DIRS for custom modules
            $env.NU_LIB_DIRS = [
              ($env.HOME | path join ".config/nushell/scripts")
              ($env.HOME | path join ".local/share/nushell")
            ]

            # NU_PLUGIN_DIRS for plugins
            $env.NU_PLUGIN_DIRS = [
              ($env.HOME | path join ".config/nushell/plugins")
            ]

            # VI indicators
            $env.PROMPT_INDICATOR_VI_NORMAL = ""
            $env.PROMPT_INDICATOR_VI_INSERT = ""

            # Carapace bridges
            $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
          '';

          extraLogin = "";

          shellAliases = { };

          environmentVariables = {
            SHELL = "${pkgs.nushell}/bin/nu";
          };
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Starship - Cross-shell prompt
        # ─────────────────────────────────────────────────────────────────────────
        starship = {
          enable = true;
          settings = pkgs.lib.importTOML "${self}/programs/starship/starship.toml";
          enableZshIntegration = true;
          enableBashIntegration = true;
          enableNushellIntegration = true;
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Shell utilities
        # ─────────────────────────────────────────────────────────────────────────
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          options = [
            "--cmd"
            "cd"
          ];
        };

        direnv = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          nix-direnv.enable = true;
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
        };

        carapace = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        # Pay-respects - thefuck replacement (cross-platform)
        pay-respects = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          package = pkgs.pay-respects;
          options = [
            "--alias"
            "fuck"
            "--nocnf"
          ];
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Shell configuration files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        # Nushell integration files
        "carapace.nu" = {
          target = ".config/nushell/integration/carapace.nu";
          text = "carapace _carapace";
        };
        "zoxide.nu" = {
          target = ".config/nushell/integration/zoxide.nu";
          text = "zoxide init nushell";
        };

        # Starship config
        starship = {
          target = ".config/starship/starship.toml";
          source = "${self}/programs/starship/starship.toml";
        };

        # Zsh scripts (executable)
        "zsh-shortcuts" = {
          target = ".config/zsh/scripts/shortcuts";
          source = "${self}/programs/zsh/scripts/shortcuts";
          executable = true;
        };
      };
    };
}
