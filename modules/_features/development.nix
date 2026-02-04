# Dendritic feature module: Development tools and languages
# Provides unified development configuration across all platforms
# Exports: homeModules.development (languages, dev utilities)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.development =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    {
      imports = [
        inputs.tmux-sessionizer.homeManagerModules.default
        # Import all language configurations
        (self + /modules/_features/_imports/languages)
      ];

      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # Development utilities
        # ─────────────────────────────────────────────────────────────────────────

        # Bat - Cat with syntax highlighting
        bat = {
          enable = true;
          config = {
            theme = "tokyonight_storm";
            pager = "less -FR";
          };
        };

        # Eza - Modern ls replacement
        eza = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          git = true;
          icons = "auto";
        };

        # Ripgrep - Fast grep
        ripgrep = {
          enable = true;
          arguments = [
            "--smart-case"
            "--hidden"
            "--glob=!.git/*"
          ];
        };

        # jq - JSON processor
        jq.enable = true;

        # nh - Nix helper tool
        nh = {
          enable = true;
          flake = null;
          homeFlake = null;
          osFlake = null;
          darwinFlake = null;
        };

        # bun - JavaScript runtime
        bun = {
          enable = true;
          settings = {
            smol = false;
            telemetry = false;
            install = {
              auto = "disable";
              saveTextLockfile = true;
            };
          };
        };

        # yazi - Terminal file manager
        yazi = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        # btop - System monitor
        btop = {
          enable = true;
          settings = {
            color_theme = "tokyo-night";
            theme_background = false;
            vim_keys = true;
          };
        };

        # opencode - AI-powered coding assistant
        opencode = {
          enable = true;
          package = pkgs.opencode;
          # https://opencode.ai/docs/config/
          settings = {
            "autoupdate" = "notify";
            "share" = "disabled";
            "theme" = "tokyonight";
            "tui" = {
              "scroll_speed" = 3;
              "scroll_acceleration" = {
                "enabled" = true;
              };
            };
            "plugin" = [
              "opencode-ignore"
              "@simonwjackson/opencode-direnv"
              "oh-my-opencode"
            ];
          };
          # opencode.ai/zen/v1/models for models
          agents = { };
          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.opencode.commands
          commands = { };
          rules = "";
        };

        # tmux-sessionizer - Tmux session manager
        tmux-sessionizer = {
          enable = true;
          enableNushell = true;
          package = pkgs.tmux-sessionizer;
          # Use our rebuilt tmux-sessionizer-nu from overlay (uses our nushell with doCheck=false)
          nushellPackage = pkgs.tmux-sessionizer-nu;
          searchPaths = [
            "~/Repos"
            "~/Documents/Repos"
            "~/Work/Repos"
            "~/Work/External/Repos"
          ];
          maxDepth = 3;
          sessionCommands = [
            "tmux renamew -t 1 'scratch'; $SHELL"
            "tmux renamew -t 2 'editor'; nvim"
            "tmux renamew -t 3 'watcher'; $SHELL"
            "tmux renamew -t 4 'agent'; opencode"
            "tmux renamew -t 5 'git'; lazygit"
          ];
          sessionTemplate = ''
            #!/usr/bin/env bash

            tmux renamew -t 1 'scratch'; clear
            tmux neww -kdS -n 'editor' -a -t 2 'nvim'
            tmux neww -kdS -n 'watcher' -a -t 3; clear
            tmux neww -kdS -n 'remote' -a -t 4 'opencode'
            tmux neww -kdS -n 'git' -a -t 5 'lazygit'
          '';
        };

        # Zed editor (Linux only - Darwin version installed via Homebrew)
        zed-editor = lib.mkIf isLinux {
          enable = false; # Disabled by default
          package = pkgs.zed;
          extraPackages = with pkgs; [
            nodejs_latest
            nixd
            jq
          ];
          extensions = [
            "awk"
            "csharp"
            "csv"
            "cython"
            "discord-presence"
            "docker-compose"
            "dockerfile"
            "ejs"
            "elixir"
            "env"
            "erlang"
            "ini"
            "java"
            "just"
            "libsql-context-server"
            "live-server"
            "lua"
            "make"
            "nix"
            "python"
            "python-requirements"
            "scss"
            "sql"
            "ssh-config"
            "tmux"
            "tokyo-night"
            "tree-sitter-query"
            "vscode-icons"
            "xml"
            "zig"
          ];
          userKeymaps = pkgs.lib.importJSON "${self}/programs/zed/keymap.json";
          userSettings = pkgs.lib.importJSON "${self}/programs/zed/settings.json";
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # Development packages
      # ─────────────────────────────────────────────────────────────────────────
      home.packages = with pkgs; [
        # Core dev tools
        gnumake
        cmake
        pkg-config

        # File utilities
        fd
        tree

        # Network utilities
        curl
        wget
        httpie

        # Archive utilities
        unzip
        zip

        # Process utilities
        htop
        procs

        # Disk utilities
        dust
        duf

        # Documentation
        tldr
        man-pages
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Development configuration files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        # File managers
        ranger = {
          target = ".config/ranger";
          source = "${self}/programs/ranger";
          recursive = true;
        };

        # Backup/sync
        rclone = {
          target = ".config/rclone";
          source = "${self}/programs/rclone";
          recursive = true;
        };

        # Bat syntax highlighting
        bat = {
          target = ".config/bat";
          source = "${self}/programs/bat";
          recursive = true;
        };

        # Yazi file manager theme
        "yazi-tokyo-night" = {
          target = ".config/yazi/flavors/tokyo-night.yazi";
          source = "${self}/programs/yazi/flavors/tokyo-night.yazi";
        };

        # Just task runner
        justfile = {
          target = ".config/just/justfile";
          source = "${self}/programs/just/justfile";
        };

        # OpenCode AI assistant
        oh-my-opencode = {
          target = ".config/opencode/oh-my-opencode.json";
          source = "${self}/programs/opencode/oh-my-opencode.json";
        };

        # ───────────────────────────────────────────────────────────────────────
        # Darwin development configuration files
        # ───────────────────────────────────────────────────────────────────────
        zed-keymap = lib.mkIf isDarwin {
          target = ".config/zed/keymap.json";
          source = "${self}/programs/zed/keymap.json";
        };
        zed-settings = lib.mkIf isDarwin {
          target = ".config/zed/settings.json";
          source = "${self}/programs/zed/settings.json";
        };
      };
    };
}
