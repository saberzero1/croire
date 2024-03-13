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
        inputs.self.nixosModules.overrides.appflowy
      ];
    };
    services = {
      espanso = {
        enable = true;
      };
    };
  };
}
