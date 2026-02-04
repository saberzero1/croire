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
        (self + /lib/modules/home/shared/languages)
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
        bat = {
          target = ".config/bat";
          source = "${self}/programs/bat";
          recursive = true;
        };

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
