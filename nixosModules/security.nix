{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.sudo
        pkgs.gnupg
        pkgs.sshpass
        pkgs.wpa_supplicant
        pkgs.wpa_supplicant_gui
        pkgs.pika-backup
      ];
    };
    programs = {
      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = true;
          settings = { };
        };
        package = pkgs.gnupg;
      };
      ssh = {
        package = pkgs.openssh;
      };
    };
    security = {
      doas = {
        enable = true;
        wheelNeedsPassword = true;
      };
      sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo;
        wheelNeedsPassword = true;
      };
      pam = {
        services = {
          swaylock = {
            enableGnomeKeyring = true;
            gnupg.enable = true;
          };
        };
        #login = {
        #  enableGnomeKeyring = true;
        #  gnupg.enable = true;
        #};
      };
    };
    services = {
      openssh = {
        enable = true;
      };
    };
    users = {
      users = {
        saberzero1 = {
          initialPassword = "changeme";
        };
      };
    };
  };
}
