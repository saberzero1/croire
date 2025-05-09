{ pkgs, config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LAZY = "${config.home.homeDirectory}/share/lazy-nvim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
}
