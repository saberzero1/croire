{ pkgs, ... }:
{
  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  environment = {
    systemPackages = with pkgs; [
      gnupg
      sshpass
    ];
    variables = {
      NIX_CONFIG = ''
        build-users-group = nixbld
        extra-trusted-users = emile
      '';
    };
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
