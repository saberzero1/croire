{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        inputs.wavebox.packages.${pkgs.system}.default
        pkgs.firefox
      ];
    };
  };
}
