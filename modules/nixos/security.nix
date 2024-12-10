{ pkgs, ... }: {
  security = {
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
    };
    pam = {
      services = {
        swaylock = {
          enableGnomeKeyring = true;
          gnupg.enable = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gnupg
      sshpass
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
        enableSSHSupport = true;
        settings = { };
      };
      package = pkgs.gnupg;
    };
    ssh = {
      package = pkgs.openssh;
    };
  };
}
