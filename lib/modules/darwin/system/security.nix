{ pkgs, ... }:
{
  security = {
    pam = {
      services.sudo_local = {
        # Use TouchID for `sudo` authentication
        touchIdAuth = true;

        # Fixes TouchID not working with tmux
        reattach = true;
      };
    };

    pki = {
      certificateFiles = builtins.filter (path: builtins.pathExists path) [
        "/etc/ssl/cert.pem"
        "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        "/etc/nix/ca_cert.pem"
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      openssh
      libressl
      gnupg
      sshpass
      cacert
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
