{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    # wezterm executes a bunch of slow commands before and after every input
    enableZshIntegration = false;
    enableBashIntegration = false;
  };
}
