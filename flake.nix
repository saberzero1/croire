{
  description = "Unified NixOS configuration.";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # will be appended to the system-level substituters
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

    # will be appended to the system-level trusted-public-keys
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

    extra-experimental-features = "nix-command flakes";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
    # lazy-trees = true;
    # eval-cores = 0; # Use all available CPU cores for evaluation
  };

  inputs = {
    # Principle inputs (updated by `nix run .#update`)

    # Unified Nix sources
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs";
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/0.1";
    # sops-nix.url = "github:Mic92/sops-nix";
    devenv.url = "github:cachix/devenv";
    nix-direnv = {
      url = "https://flakehub.com/f/nix-community/nix-direnv/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-direnv.url = "github:nix-community/nix-direnv";
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0.1";
    flake-parts.url = "github:hercules-ci/flake-parts";
    #nixos-unified.url = "github:srid/nixos-unified";
    nixos-unified.url = "github:saberzero1/nixos-unified/overlays";
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
    systems.url = "github:nix-systems/default";

    # Determinate nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    # nix.url = "https://flakehub.com/f/DeterminateSystems/nix/*";
    # determinate-nix.url = "github:DeterminateSystems/nix-src";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*";

    # Doom Emacs
    # nix-doom-emacs-unstraightened = {
    #   url = "github:marienz/nix-doom-emacs-unstraightened";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # CI
    devour-flake = {
      url = "github:srid/devour-flake";
      flake = false;
    };

    # WSL-specific
    # nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Darwin-specific
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-felixkratz-tap = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };
    homebrew-nikitabobko-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };

    # mac-app-util.url = "github:hraban/mac-app-util";
    spacebar.url = "github:cmacrae/spacebar/v1.4.0";

    # Home-manager
    home-manager = {
      # url = "https://flakehub.com/f/nix-community/home-manager/*";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Software inputs
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf/main";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim.url = "github:saberzero1/lazyvim-nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # wezterm = {
    #   url = "github:wez/wezterm/main?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-snapd = {
      url = "https://flakehub.com/f/nix-community/nix-snapd/*";
      # url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/*";
    # nix-alien.url = "github:thiagokokada/nix-alien";
    ghostty.url = "github:ghostty-org/ghostty";
    # gitbutler = {
    #   url = "github:gitbutlerapp/gitbutler";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    helix = {
      url = "https://flakehub.com/f/helix-editor/helix/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zed.url = "github:zed-industries/zed";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Gaming
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    play-nix = {
      url = "github:TophC7/play.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.chaotic.follows = "chaotic";
    };
    geforce-infinity = {
      url = "github:saberzero1/GeForce-Infinity/copilot/add-nix-flake-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dotfiles
    totten = {
      url = "github:saberzero1/totten/master";
      flake = false;
    };

    # Omnix
    omnix.url = "github:juspay/omnix";
    tmux-sessionizer = {
      url = "github:saberzero1/tmux-sessionizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sash = {
      url = "https://flakehub.com/f/saberzero1/sash/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
      systems = [
        "x86_64-linux"
        # "aarch64-linux"
        "aarch64-darwin"
      ];
    };
}
