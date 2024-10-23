{ inputs, ... }@flakeContext:
{ config, lib, pkgs, fetchzip, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.ulauncher
        pkgs.freerdp
        pkgs.espanso
        #pkgs.espanso-wayland
      ];
    };
    systemd = {
      services = {
        espanso = {
          enable = true;
          serviceConfig = {
            execStart = "${pkgs.espanso}/bin/espanso start";
            Restart = "always";
            RestartSec = 1;
          };
        };
      };
    };
  };
}
