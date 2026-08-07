# Dendritic feature module: Terminal configuration
# Provides unified terminal configuration across all platforms
# Exports: homeModules.terminal (tmux, ghostty, wezterm)
{ inputs, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.terminal =
    {
      pkgs,
      config,
      lib,
      flake,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
      _ = config.home.homeDirectory;

      # Ghostty font features
      fontFeatures = [
        "calt"
        "clig"
        "zero"
        "liga"
        "dlig"
        "ss01"
        "ss02"
        "ss03"
        "ss04"
        "ss05"
        "ss06"
        "ss07"
        "ss08"
        "ss09"
        "ss10"
        "ss11"
        "ss12"
        "ss13"
        "ss14"
        "ss15"
      ];
    in
    {
      programs = {
        # ─────────────────────────────────────────────────────────────────────────
        # Tmux - Terminal multiplexer
        # ─────────────────────────────────────────────────────────────────────────
        tmux = {
          enable = true;
          prefix = "C-a";
          sensibleOnTop = true;
          shortcut = "a";
          clock24 = true;
          baseIndex = 1;
          escapeTime = 0;
          keyMode = "vi";
          secureSocket = false;
          shell = "${pkgs.nushell}/bin/nu";
          plugins = with pkgs.tmuxPlugins; [
            fpp
            yank
            better-mouse-mode
            tokyo-night-tmux
            sensible
            resurrect
            power-theme
            mode-indicator
            tmux-which-key
          ];
          extraConfig = ''
            # True color support
            set -g default-terminal "screen-256color"
            set -ga terminal-overrides ",*256col*:Tc"
            set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
            set-environment -g COLORTERM "truecolor"

            set-option -g default-shell $SHELL

            # Mouse support
            set-option -g mouse on

            # Split pane commands
            bind | split-window -h -c "#{pane_current_path}"
            bind - split-window -v -c "#{pane_current_path}"
            bind c new-window -c "#{pane_current_path}"

            # Session management
            bind-key -r f run-shell "tmux neww ~/.config/tmux/scripts/tmux-sessionizer"
            bind-key -r q run-shell "tmux kill-session"

            set -g default-command "$SHELL"

            # Quick window switching
            bind-key 1 run-shell -c '#{pane_current_path}' "tmux select-window -t 1 || tmux new-window -t 1 -n 'scratch' -c '#{pane_current_path}' $SHELL";
            bind-key 2 run-shell -c '#{pane_current_path}' "tmux select-window -t 2 || tmux new-window -t 2 -n 'editor' -c '#{pane_current_path}' nvim";
            bind-key 3 run-shell -c '#{pane_current_path}' "tmux select-window -t 3 || tmux new-window -t 3 -n 'watcher' -c '#{pane_current_path}' $SHELL";
            bind-key 4 run-shell -c '#{pane_current_path}' "tmux select-window -t 4 || tmux new-window -t 4 -n 'remote' -c '#{pane_current_path}' opencode";
            bind-key 5 run-shell -c '#{pane_current_path}' "tmux select-window -t 5 || tmux new-window -t 5 -n 'git' -c '#{pane_current_path}' lazygit";
            bind-key 6 run-shell -c '#{pane_current_path}' "tmux select-window -t 6 || tmux new-window -t 6 -c '#{pane_current_path}'";
            bind-key 7 run-shell -c '#{pane_current_path}' "tmux select-window -t 7 || tmux new-window -t 7 -c '#{pane_current_path}'";
            bind-key 8 run-shell -c '#{pane_current_path}' "tmux select-window -t 8 || tmux new-window -t 8 -c '#{pane_current_path}'";
            bind-key 9 run-shell -c '#{pane_current_path}' "tmux select-window -t 9 || tmux new-window -t 9 -c '#{pane_current_path}'";
            bind-key 0 run-shell -c '#{pane_current_path}' "tmux select-window -t 10 || tmux new-window -t 10 -c '#{pane_current_path}'";
          '';
        };

        # ─────────────────────────────────────────────────────────────────────────
        # Ghostty - GPU-accelerated terminal (Linux only for now)
        # ─────────────────────────────────────────────────────────────────────────
        ghostty = lib.mkIf isLinux {
          enable = true;
          package = pkgs.ghostty;
          settings = {
            font-size = 18;
            font-family = "Monaspace Neon";
            font-family-bold = "Monaspace Xenon";
            font-family-italic = "Monaspace Radon";
            font-family-bold-italic = "Monaspace Krypton";
            font-feature = fontFeatures;
            theme = "dark:TokyoNight Storm,light:TokyoNight Day";
            shell-integration = "none";
          };
        };

        # ─────────────────────────────────────────────────────────────────────────
        # WezTerm - Cross-platform terminal
        # ─────────────────────────────────────────────────────────────────────────
        wezterm = {
          enable = isLinux; # Only enabled on Linux
          package = pkgs.wezterm;
          enableZshIntegration = false;
          enableBashIntegration = false;
        };
      };

      # Helper scripts
      home.packages = [
        # Open tmux for current project
        (pkgs.writeShellApplication {
          name = "pux";
          runtimeInputs = [ pkgs.tmux ];
          text = ''
            PRJ="''$(zoxide query -i)"
            echo "Launching tmux for ''$PRJ"
            set -x
            cd "''$PRJ" && \
              exec tmux -S "''$PRJ".tmux attach
          '';
        })

        # Herdr - Terminal multiplexer for AI agents
        flake.inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default

        # Bootstrap a Herdr workspace with named tabs (mirrors tmux layout)
        # Note: Unlike tmux, Herdr tabs are persistent shells. Exiting nvim/lazygit
        # returns to the shell prompt (the tab stays open). Tab indices are contiguous
        # and shift when a tab is closed (no fixed numbering like tmux).
        (pkgs.writeShellApplication {
          name = "herdr-bootstrap";
          runtimeInputs = [
            flake.inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
            pkgs.jq
          ];
          text = ''
            CWD="''${1:-$(pwd)}"

            # Rename the default first tab to 'scratch'
            FIRST_TAB=$(herdr tab list 2>/dev/null | jq -r '.result.tabs[0].tab_id // empty')
            if [ -n "$FIRST_TAB" ]; then
              herdr tab rename "$FIRST_TAB" "scratch" >/dev/null 2>&1 || true
            fi

            # Helper: create tab and launch command as foreground process
            create_tab() {
              local label="$1" cwd="$2" cmd="''${3:-}"
              local json pane_id
              json=$(herdr tab create --label "$label" --cwd "$cwd" 2>/dev/null) || return
              if [ -n "$cmd" ]; then
                pane_id=$(echo "$json" | jq -r '.result.root_pane.pane_id // empty')
                if [ -n "$pane_id" ]; then
                  sleep 0.2
                  # Send command as keystrokes so it runs as foreground process
                  herdr pane send-text "$pane_id" "$cmd" >/dev/null 2>&1 || true
                  herdr pane send-keys "$pane_id" enter >/dev/null 2>&1 || true
                fi
              fi
            }

            create_tab "editor"  "$CWD" "nvim"
            create_tab "watcher" "$CWD"
            create_tab "agent"   "$CWD" "opencode"
            create_tab "git"     "$CWD" "lazygit"

            # Focus back on the first tab
            if [ -n "$FIRST_TAB" ]; then
              herdr tab focus "$FIRST_TAB" >/dev/null 2>&1 || true
            fi
          '';
        })
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # Terminal configuration files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        wezterm = {
          target = ".config/wezterm";
          source = "${self}/programs/wezterm";
          recursive = true;
        };
        ghostty = lib.mkIf isDarwin {
          target = ".config/ghostty";
          source = "${self}/programs/ghostty";
          recursive = true;
        };
        # Herdr agent integrations (declarative)
        # Managed by Nix instead of `herdr integration install`.
        # Re-run `herdr integration install <target>` to get updated versions,
        # then copy the content here.
        herdr-claude-integration = {
          target = ".claude/hooks/herdr-agent-state.sh";
          executable = true;
          source = "${self}/programs/herdr/claude-integration.sh";
        };
        herdr-opencode-integration = {
          target = ".config/opencode/plugins/herdr-agent-state.js";
          source = "${self}/programs/herdr/opencode-integration.js";
        };
        herdr-config = {
          target = ".config/herdr/config.toml";
          text = ''
            onboarding = false

            [theme]
            name = "tokyo-night"

            [terminal]
            default_shell = "${pkgs.nushell}/bin/nu"
            shell_mode = "login"
            new_cwd = "follow"

            [keys]
            prefix = "ctrl+a"
            split_vertical = "prefix+|"
            split_horizontal = "prefix+-"
            new_tab = "prefix+c"
            close_tab = "prefix+shift+x"
            close_pane = "prefix+x"
            switch_tab = "prefix+1..9"
            zoom = "prefix+z"
            resize_mode = "prefix+r"
            copy_mode = "prefix+["
            detach = "prefix+q"
            help = "prefix+?"

            # Pane navigation (vim-style)
            focus_pane_left = "prefix+h"
            focus_pane_down = "prefix+j"
            focus_pane_up = "prefix+k"
            focus_pane_right = "prefix+l"

            # Lazygit popup
            [[keys.command]]
            key = "prefix+g"
            type = "popup"
            command = "lazygit"
            width = "90%"
            height = "90%"

            [ui]
            mouse_capture = true
            tab_bar_position = "top"
            prompt_new_tab_name = false

            [ui.toast]
            delivery = "herdr"

            [session]
            resume_agents_on_restore = true

            [advanced]
            scrollback_limit_bytes = 50000000
          '';
        };

      };
    };
}
