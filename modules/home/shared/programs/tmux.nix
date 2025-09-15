{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    sensibleOnTop = true;
    shortcut = "a";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    secureSocket = false;
    shell = "${pkgs.zsh}/bin/zsh";
    tmuxp.enable = true;
    plugins = with pkgs.tmuxPlugins; [
      fpp # Facebook Path Picker
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
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      # set -g default-terminal "xterm-256color"
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set-option -g default-shell $SHELL

      # Mouse works as expected
      set-option -g mouse on

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind-key -r f run-shell "tmux neww ~/.config/tmux/scripts/tmux-sessionizer"
      bind-key -r q run-shell "tmux kill-session"

      # bind-key -r k run-shell "~/.local/scripts/tmux-sessionizer ~/projects/work/tmux-theme"

      set -g default-command "$SHELL"

      bind-key 1 run-shell -c '#{pane_current_path}' "tmux select-window -t 1 || tmux new-window -t 1 -n 'scratch' -c '#{pane_current_path}' $SHELL";
      bind-key 2 run-shell -c '#{pane_current_path}' "tmux select-window -t 2 || tmux new-window -t 2 -n 'editor' -c '#{pane_current_path}' nvim";
      bind-key 3 run-shell -c '#{pane_current_path}' "tmux select-window -t 3 || tmux new-window -t 3 -n 'watcher' -c '#{pane_current_path}' $SHELL";
      bind-key 4 run-shell -c '#{pane_current_path}' "tmux select-window -t 4 || tmux new-window -t 4 -n 'remote' -c '#{pane_current_path}' $SHELL";
      bind-key 5 run-shell -c '#{pane_current_path}' "tmux select-window -t 5 || tmux new-window -t 5 -n 'git' -c '#{pane_current_path}' lazygit";
      bind-key 6 run-shell -c '#{pane_current_path}' "tmux select-window -t 6 || tmux new-window -t 6 -c '#{pane_current_path}'";
      bind-key 7 run-shell -c '#{pane_current_path}' "tmux select-window -t 7 || tmux new-window -t 7 -c '#{pane_current_path}'";
      bind-key 8 run-shell -c '#{pane_current_path}' "tmux select-window -t 8 || tmux new-window -t 8 -c '#{pane_current_path}'";
      bind-key 9 run-shell -c '#{pane_current_path}' "tmux select-window -t 9 || tmux new-window -t 9 -c '#{pane_current_path}'";
      bind-key 0 run-shell -c '#{pane_current_path}' "tmux select-window -t 10 || tmux new-window -t 10 -c '#{pane_current_path}'";
    '';
  };

  home.packages = [
    # Open tmux for current project.
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
}
