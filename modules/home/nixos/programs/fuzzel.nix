{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
  };
}
