{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LAZY = "$HOME/share/lazy-nvim";
  };
}
