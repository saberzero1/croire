{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.sudo
      ];
    };
    security = {
      doas = {
        enable = true;
        wheelNeedsPassword = true;
      };
      sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo;
        wheelNeedsPassword = true;
      };
    };
  };
}
