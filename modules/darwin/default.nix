# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{ ... }:
{
  imports = [
    ./dock
    ./packages
    ./services
    ./system
  ];

  # These users can add Nix caches.
  nix = {
    enable = false;
    settings.trusted-users = [
      "root"
      "emile"
    ];
    channel = {
      enable = true;
    };
  };

  local = {
    dock.enable = true;
    dock.entries = [
      { path = "/Applications/Wavebox.app"; }
      { path = "/Applications/Ghostty.app"; }
      # { path = "/etc/profiles/per-user/emile/bin/ghostty"; }
      { path = "/Applications/Obsidian.app"; }
      # { path = "${pkgs.wezterm}/Applications/Wezterm.app"; }
    ];
  };

  # Fix for Nix not using macOS system CA certificates
  system.activationScripts."ssl-ca-cert-fix".text = ''
    if [ ! -f /etc/nix/ca_cert.pem ]; then
      security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
      security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
      cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
      sudo mkdir -p /etc/nix
      sudo mv /tmp/ca_cert.pem /etc/nix/
    fi
  '';

  nix.settings = {
    ssl-cert-file = "/etc/nix/ca_cert.pem";
  };
}
