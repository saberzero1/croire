{ pkgs, ... }:
{
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    package = pkgs.sudo;
    wheelNeedsPassword = true;
  };
}
