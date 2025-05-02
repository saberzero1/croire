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
      set -g default-terminal "xterm-256color"
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

      bind-key -r f run-shell "tmux new-window ~/.config/tmux/scripts/tmux-sessionizer"

      # bind-key -r k run-shell "~/.local/scripts/tmux-sessionizer ~/projects/work/tmux-theme"

      set -g default-command $SHELL

      # startup windows
      tmux new-window -kS -n "scratch" -t 1 zsh
      tmux new-window -kS -n "editor" -t 2 nvim
      tmux new-window -kS -n "watcher" -t 3 zsh
      tmux new-window -kS -n "remote" -t 4 zsh 
      tmux new-window -kS -n "git" -t 5 lazygit
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
