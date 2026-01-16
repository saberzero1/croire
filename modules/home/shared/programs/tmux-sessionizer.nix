{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.tmux-sessionizer.homeManagerModules.default
  ];

  programs.tmux-sessionizer = {
    enable = true;
    package = pkgs.tmux-sessionizer;
    searchPaths = [
      "~/Repos"
      "~/Documents/Repos"
      "~/Work/Repos"
      "~/Work/External/Repos"
    ];
    maxDepth = 3;
    sessionCommands = [
      "tmux renamew -t 1 'scratch' && $SHELL"
      "tmux renamew -t 2 'editor' && nvim"
      "tmux renamew -t 3 'watcher' && $SHELL"
      "tmux renamew -t 4 'agent' && opencode"
      "tmux renamew -t 5 'git' && lazygit"
    ];
    sessionTemplate = ''
      #!/usr/bin/env bash

      tmux renamew -t 1 'scratch' && clear
      tmux neww -kdS -n 'editor' -a -t 2 'nvim' && clear
      tmux neww -kdS -n 'watcher' -a -t 3 '$SHELL' && clear
      tmux neww -kdS -n 'remote' -a -t 4 'opencode' && clear
      tmux neww -kdS -n 'git' -a -t 5 'lazygit' && clear
    '';
  };
}
