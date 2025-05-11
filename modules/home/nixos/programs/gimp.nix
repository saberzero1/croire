{ pkgs, ... }:
{
  programs.gimp = {
    enable = true;
    package = pkgs.gimp3-with-plugins;
  };
}
