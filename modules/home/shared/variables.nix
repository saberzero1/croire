{ ... }:
{
  home = {
    sessionPath = [
      "$HOME/.config/tmux/scripts"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LAZY = "$HOME/share/lazy-nvim";
    };
  };
}
