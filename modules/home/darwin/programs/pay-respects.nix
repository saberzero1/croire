{ pkgs, ... }:
{
  programs.pay-respects = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    package = pkgs.pay-respects;
  };
}
