{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.vlc
        pkgs.steam
      ];
    };
    programs = {
      steam = {
        enable = true;
        package = pkgs.steam;
      };
    };
  };
}
