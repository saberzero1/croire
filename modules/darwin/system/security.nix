{ pkgs, ... }:
{
  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;

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
  };

}
