{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    inputs.self.nixosModulesOverrides
  ];
  config = {
    environment = {
      systemPackages = [
        pkgs.ulauncher
        pkgs.freerdp
        pkgs.espanso
        pkgs.appflowy
      ];
    };
    services = {
      espanso = {
        enable = true;
      };
    };
  };
}
