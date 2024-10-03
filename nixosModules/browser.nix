{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.wavebox-io
        pkgs.firefox
      ];
    };
  };
}
