{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vlc
        pkgs.steam
      ];
    };
  };
}
