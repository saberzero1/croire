{ pkgs, config, ... }:
let
  just = {
    JUST_CHOOSER = "${pkgs.fzf}/bin/fzf";
    JUST_COLOR = "always";
    JUST_TIMESTAMP = "true";
    JUST_TIMESTAPM_FORMAT = "%Y-%m-%d %H:%M:%S";
    JUST_UNSTABLE = "true";
  };
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LAZY = "${config.home.homeDirectory}/share/lazy-nvim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  } // just;
}
