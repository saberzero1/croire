# Dendritic feature module: Terminal configuration
# Provides unified terminal configuration across all platforms
# Exports: homeModules.terminal (tmux, ghostty, wezterm)
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.terminal =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;

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
      };
    };
}
