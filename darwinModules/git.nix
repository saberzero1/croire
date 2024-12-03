{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.diff-so-fancy
        pkgs.gh
        pkgs.lazygit
        pkgs.git
      ];
    };
  };
}