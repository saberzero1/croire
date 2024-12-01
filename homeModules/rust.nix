{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = {
        systemPackages = [
          pkgs.rustup
          pkgs.nixd
        ];
      };
    };
  };
}
