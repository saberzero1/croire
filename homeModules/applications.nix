{ inputs, ... }@flakeContext:
{ config, lib, pkgs, username, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vlc
        pkgs.steam
      ];
    };
  };
}
