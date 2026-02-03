# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{ flake
, pkgs
, lib
, ...
}:
{
  imports = [
    flake.inputs.determinate.darwinModules.default
    # flake.inputs.mac-app-util.darwinModules.default
    flake.inputs.nix-homebrew.darwinModules.nix-homebrew
    ./dock
    ./packages
    ./services
    ./system
  ];

  # These users can add Nix caches.
  nix = {
    enable = false;
    # package = lib.mkDefault pkgs.nix;
    settings = {
      trusted-users = [
        "root"
        "emile"
      ];
      substituters = [
        # nixos cache server
        "https://cache.nixos.org"
        # nix community's cache server
        "https://nix-community.cachix.org"
        # cachix's cache server
        "https://cachix.cachix.org"
        # nixpkgs cache server
        "https://nixpkgs.cachix.org"
        # omnix cachix binaries
        "https://om.cachix.org"
        # determinate binaries
        "https://cache.flakehub.com"
        "https://install.determinate.systems"
        # hyprland cachix binaries
        "https://hyprland.cachix.org"
        # personal cachix binaries
        "https://saberzero1.cachix.org"
        # sash cachix binaries
        "https://sash.cachix.org"
      ];
      trusted-public-keys = [
        # nixos cache server public key
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # nix community's cache server public key
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # cachix's cache server public key
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        # nixpkgs cache server public key
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
        # omnix cachix binaries public key
        "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
        # determinate binaries public keys
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
        # hyprland cachix binaries public key
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # personal cachix binaries public key
        "saberzero1.cachix.org-1:VjGzK8nJmRf+ghLAmi3SSNswTSLdg53IGdqhQJMdQdk="
        # sash cachix binaries public key
        "sash.cachix.org-1:O4mYArEPtU859GLhV67RWcs9sdAa0mLyS+CBzDHGLNs="
      ];
    };
    channel = {
      enable = true;
    };
  };
  # Determinate Nix settings
  # These are written to /etc/nix/nix.custom.conf
  determinateNix.customSettings = {
    eval-cores = 0;
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "emile"
    ];
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
