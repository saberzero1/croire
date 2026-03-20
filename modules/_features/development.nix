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
            # Route Anthropic requests through claude-max-proxy (passthrough mode)
            # Proxy runs at localhost:7154, bridging Claude Max subscription via Agent SDK
            "provider" = {
              "anthropic" = {
                "options" = {
                  "apiKey" = "dummy";
                  "baseURL" = "http://127.0.0.1:7154";
                };
              };
            };
            "plugin" = [
              "opencode-ignore"
              "@simonwjackson/opencode-direnv"
              "oh-my-opencode"
              # "@tarquinen/opencode-dcp@latest"
              "opencode-mystatus"
              # claude-max-proxy session resume plugin (from local install)
              "${config.home.homeDirectory}/.local/share/opencode-claude-max-proxy/src/plugin/claude-max-headers.ts"
            ];
          };
          # opencode.ai/zen/v1/models for models
          agents = { };
          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.opencode.commands
          commands = { };
          rules = "";
        };

        # claude-code - Anthropic's official AI coding CLI
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.claude-code.enable
        claude-code = {
          enable = true;
          settings = {
            # Disable auto-updates (managed by Nix)
            autoUpdaterStatus = "disabled";
            theme = "dark";
            includeCoAuthoredBy = false;
            # Permissions
            permissions = {
              # Safer default: allow edits, require approval for commands
              defaultMode = "acceptEdits";
              # Prevent bypassing permissions mode
              disableBypassPermissionsMode = "disable";
            };
            # Plugins (from plugin marketplaces)
            # Format: "plugin-name@marketplace-name" = true/false
            enabledPlugins = {
              "github@claude-plugins-official" = true;
              "oh-my-claudecode@omc" = true;
            };
            "statusLine" = {
              "type" = "command";
              "command" = "node /home/saberzero1/.claude/hud/omc-hud.mjs";
            };
          };
          # MCP (Model Context Protocol) servers
          # Claude Code equivalent of OpenCode plugins for external integrations
          # NOTE: GitHub Copilot MCP and other OAuth-dependent servers are
          # managed via the plugin system (enabledPlugins in settings above).
          mcpServers = {
            # Filesystem MCP - local filesystem access
            filesystem = {
              command = "npx";
              args = [
                "-y"
                "@modelcontextprotocol/server-filesystem"
                config.home.homeDirectory
              ];
              type = "stdio";
            };
            # Context7 MCP - documentation lookup
            context7 = {
              command = "npx";
              args = [
                "-y"
                "@upstash/context7-mcp"
              ];
              type = "stdio";
            };
            github = {
              type = "http";
              url = "https://api.githubcopilot.com/mcp/";
            };
          };
          # Custom commands, rules, and memory can be added here:
          # commands = { };
          # rules = { };
          # memory.text = "";
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
        just
        # nodejs_latest

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

        # Desktop utilities
        # opencode-desktop
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Development configuration files
      # ─────────────────────────────────────────────────────────────────────────
      # Declarative Claude Code marketplace management
      # Registers third-party plugin marketplaces (clones repos on first run).
      # Plugin enablement is handled declaratively via enabledPlugins in settings.
      # Uses the unwrapped package to avoid --mcp-config flag interference.
      home.activation.claudeCodeMarketplaces =
        let
          claude = "${config.programs.claude-code.package}/bin/claude";
          # Third-party marketplaces to register (official marketplace is auto-managed)
          marketplaces = [ "https://github.com/Yeachan-Heo/oh-my-claudecode" ];
          marketplaceCmds = lib.concatMapStringsSep "\n" (
            url: ''run ${claude} plugin marketplace add "${url}" 2>/dev/null || true''
          ) marketplaces;
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${marketplaceCmds}
        '';

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
          # source = "${self}/programs/opencode/oh-my-opencode-zen.json";
          # source = "${self}/programs/opencode/oh-my-opencode.json";
          source = "${self}/programs/opencode/oh-my-opencode-claude.json";
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
