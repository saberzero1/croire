{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    appstream = {
      enable = true;
    };
    environment = {
      systemPackages = [
        pkgs.vlc
        pkgs.steam
        pkgs.obsidian
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
