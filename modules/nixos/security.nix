{ pkgs, ... }:
{
  security = {
    polkit = {
      enable = true;
    };

    rtkit = {
      enable = true;
    };

    doas = {
      enable = true;
      wheelNeedsPassword = true;
    };

    sudo = {
      enable = true;
      execWheelOnly = true;
      package = pkgs.sudo;
      wheelNeedsPassword = true;
      extraConfig = ''
        Defaults timestamp_timeout=60
      '';
    };

    pam = {
      services = {
        hyprlock = {
          enableGnomeKeyring = true;
          gnupg.enable = true;
        };

        login = {
          enableGnomeKeyring = true;
          gnupg.enable = true;
        };
      };
      # Fixes "Too many open files" errors
      loginLimits = [
        {
          domain = "*";
          type = "soft";
          item = "nofile";
          value = "65536";
        }
        {
          domain = "*";
          type = "hard";
          item = "nofile";
          value = "1048576";
        }
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gnupg
      sshpass
      seahorse
      sudo
      wpa_supplicant
      wpa_supplicant_gui
      pika-backup
    ];
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = false;
        settings = { };
      };
      package = pkgs.gnupg;
    };

    ssh = {
      package = pkgs.openssh;
      startAgent = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };

    seahorse = {
      enable = true;
    };

    yubikey-touch-detector = {
      enable = false;
    };
  };
}
