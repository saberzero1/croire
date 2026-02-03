{ pkgs, ... }:
{
  programs.rclone = {
    enable = true;
    package = pkgs.rclone;
  };
}
