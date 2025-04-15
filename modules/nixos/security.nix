{ pkgs, ... }:
{

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
