{ pkgs, ... }:
{
  programs.ranger = {
    enable = true;
    package = pkgs.ranger;
  };
}
