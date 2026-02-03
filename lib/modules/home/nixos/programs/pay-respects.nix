{ pkgs, ... }:
{
  programs.pay-respects = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    package = pkgs.pay-respects;
  };
}
