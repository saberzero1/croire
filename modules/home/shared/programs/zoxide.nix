{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
