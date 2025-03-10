{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gnupg
      sshpass
    ];
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    yubikey-touch-detector = {
      enable = false;
    };
  };
}
