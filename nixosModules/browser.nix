{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        inputs.modifications.wavebox.packages.${pkgs.system}.default
        pkgs.firefox
      ];
    };
  };
}
