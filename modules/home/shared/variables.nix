{ pkgs, ... }:
{
  home = {
    sessionPath = [
      "$HOME/.config/scripts/tmux"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LAZY = "$HOME/share/lazy-nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
}
