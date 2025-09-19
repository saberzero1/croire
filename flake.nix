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
      # personal cachix binaries
      "https://saberzero1.cachix.org"
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
      # personal cachix binaries public key
      "saberzero1.cachix.org-1:VjGzK8nJmRf+ghLAmi3SSNswTSLdg53IGdqhQJMdQdk="
    ];

    extra-experimental-features = "nix-command flakes parallel-eval";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
    lazy-trees = true;
    eval-cores = 0; # Use all available CPU cores for evaluation
  };

  inputs = {
    # Principle inputs (updated by `nix run .#update`)

    # Unified Nix sources
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/0.1";
    devenv.url = "github:cachix/devenv";
    nix-direnv.url = "https://flakehub.com/f/nix-community/nix-direnv/*";
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0.1";
    nixos-unified.url = "github:srid/nixos-unified";
    #nixos-unified.url = "github:saberzero1/nixos-unified";
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1";
    systems.url = "github:nix-systems/default";

    # Determinate nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix/*";

    # Doom Emacs
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WSL-specific
    # nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Darwin-specific
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
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

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Software inputs
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-snapd = {
      url = "https://flakehub.com/f/nix-community/nix-snapd/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/*";
    /*
      ghostty = {
        url = "github:clo4/ghostty-hm-module";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    */
    ghostty.url = "github:ghostty-org/ghostty";
    gitbutler = {
      url = "github:gitbutlerapp/gitbutler";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dotfiles
    totten = {
      url = "github:saberzero1/totten/master";
      flake = false;
    };

    # Omnix
    omnix.url = "github:juspay/omnix";
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
  /*
    outputs =
      inputs@{ self, ... }:
      inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        systems = [
          "x86_64-linux"
          # "aarch64-linux"
          "aarch64-darwin"
        ];
        imports = (
          with builtins; map (fn: ./modules/flake-parts/${fn}) (attrNames (readDir ./modules/flake-parts))
        );

        perSystem =
          { lib, system, ... }:
          {
            # Make our overlay available to the devShell
            # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
            # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = lib.attrValues self.overlays;
              config.allowUnfree = true;
            };
          };

          # https://omnix.page/om/ci.html
          flake.om.ci.default.ROOT = {
            dir = ".";
            steps.flake-check.enable = false; # Doesn't make sense to check nixos config on darwin!
            steps.custom = { };
          };
      };
  */
  /*
    outputs =
      {
        self,
        nixpkgs,
        home-manager,
        devenv,
        darwin,
        nix-homebrew,
        homebrew-bundle,
        homebrew-core,
        homebrew-cask,
        flake-utils,
        ...
      }@inputs:
      let
        # overlays = [
        #   (self: super: {
        #     #nvim-nightly = inputs.neovim-nightly-overlay.overlays.default;
        #     espanso = super.espanso.override {
        #       x11Support = false;
        #       waylandSupport = true;
        #     };
        #     wavebox = super.wavebox.override {
        #       version = "10.129.32-2";
        #     };
        #   })
        # ];
        # pkgs = import nixpkgs { inherit overlays; };
        #system = nixpkgs.pkgs.system;
        #system = "x86_64-linux";
        #system = builtins.currentSystem;
        system = "$(nix eval --impure --raw --expr 'builtins.currentSystem')";
        linuxSystem = "x86-64-linux";
        darwinSystem = "aarch64-darwin";
        # forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
          ];
          config = {
            allowUnfree = true;
          };
        };
        flakeContext = {
          inherit inputs;
          inherit (self) outputs;
        };
      in
      {
        #overlays = [
        #  inputs.neovim-nightly-overlay.overlays.default
        #(_: _: {
        #  nil = inputs.nil-lsp.packages."x86_64-linux".default;
        #})
        #(final: prev: {
        #    # Override nil-lsp with a specific Rust toolchain
        #    nil = prev.nil.overrideAttrs (old: {
        #      nativeBuildInputs = old.nativeBuildInputs or [] ++ [
        #        (final.rust-bin.stable."1.77.0".default.override {
        #          extensions = [ ];  # Add any extensions you need
        #        })
        #      ];
        #    });
        #  })
        #];
        #overlays = import ./overlays/default.nix flakeContext;
        overlays.default = (
          self: super: {
            #espanso = super.espanso.override {
            #  x11Support = false;
            #  waylandSupport = true;
            #};
            wavebox = super.wavebox.override {
              version = "10.129.32-2";
            };
          }
        );
        #legacyPackages.x86_64-linux = pkgs.pkgs;
        legacyPackages.${system} = pkgs.pkgs;
        username = "saberzero1";
        darwinConfigurations = {
          Emiles-MacBook-Pro = import ./darwinConfigurations/Emiles-MacBook-Pro.nix flakeContext;
          #Emiles-MacBook-Pro = import ~/Documents/Repos/dotfiles-submodules/croire/darwinConfigurations/Emiles-MacBook-Pro.nix flakeContext;
        };
        darwinModules = {
          #casks = import ./darwinModules/casks.nix flakeContext;
          #dock = import ./darwinModules/dock/default.nix flakeContext;
          #files = import ./darwinModules/files.nix flakeContext;
          git = import ./darwinModules/git.nix flakeContext;
          home = import ./darwinModules/home.nix flakeContext;
          #home-settings = import ./darwinModules/home-settings.nix flakeContext;
          #packages = import ./darwinModules/packages.nix flakeContext;
          security = import ./darwinModules/security.nix flakeContext;
        };
        homeConfigurations = {
          saberzero1 = import ./homeConfigurations/saberzero1.nix flakeContext;
        };
        homeModules = {
          applications = import ./homeModules/applications.nix flakeContext;
          browser = import ./homeModules/browser.nix flakeContext;
          console = import ./homeModules/console.nix flakeContext;
          desktop = import ./homeModules/desktop.nix flakeContext;
          development = import ./homeModules/development.nix flakeContext;
          git = import ./homeModules/git.nix flakeContext;
          javascript = import ./homeModules/javascript.nix flakeContext;
          neovim_language_dependencies = import ./homeModules/neovim_language_dependencies.nix flakeContext;
          nixvim = import ./homeModules/nixvim.nix flakeContext;
          programming_languages = import ./homeModules/programming_languages.nix flakeContext;
          lua = import ./homeModules/lua.nix flakeContext;
          python = import ./homeModules/python.nix flakeContext;
          ruby = import ./homeModules/ruby.nix flakeContext;
          rust = import ./homeModules/rust.nix flakeContext;
          security = import ./homeModules/security.nix flakeContext;
          system = import ./homeModules/system.nix flakeContext;
          utils = import ./homeModules/utils.nix flakeContext;
          vscodium = import ./homeModules/vscodium.nix flakeContext;
          workflow = import ./homeModules/workflow.nix flakeContext;
        };
        nixosConfigurations = {
          croire = import ./nixosConfigurations/croire.nix flakeContext;
          croire-low = import ./nixosConfigurations/croire-low.nix flakeContext;
          nixos = import ./nixosConfigurations/nixos.nix flakeContext;
        };
        nixosModules = {
          applications = import ./nixosModules/applications.nix flakeContext;
          browser = import ./nixosModules/browser.nix flakeContext;
          console = import ./nixosModules/console.nix flakeContext;
          desktop = import ./nixosModules/desktop.nix flakeContext;
          development = import ./nixosModules/development.nix flakeContext;
          git = import ./nixosModules/git.nix flakeContext;
          javascript = import ./nixosModules/javascript.nix flakeContext;
          neovim = import ./nixosModules/neovim.nix flakeContext;
          programming_languages = import ./nixosModules/programming_languages.nix flakeContext;
          lua = import ./nixosModules/lua.nix flakeContext;
          python = import ./nixosModules/python.nix flakeContext;
          ruby = import ./nixosModules/ruby.nix flakeContext;
          rust = import ./nixosModules/rust.nix flakeContext;
          security = import ./nixosModules/security.nix flakeContext;
          system = import ./nixosModules/system.nix flakeContext;
          utils = import ./nixosModules/utils.nix flakeContext;
          vscodium = import ./nixosModules/vscodium.nix flakeContext;
          workflow = import ./nixosModules/workflow.nix flakeContext;
        };
        };
  */
}
