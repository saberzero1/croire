{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.sudo
        pkgs.gnupg
      ];
    };
    programs = {
      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = true;
          settings = { };
        };
        package = pkgs.gnupg;
      };
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
