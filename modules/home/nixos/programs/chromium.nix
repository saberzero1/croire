{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.wavebox;
  };
}
