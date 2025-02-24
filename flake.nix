{
  description = "Unified NixOS configuration.";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # will be appended to the system-level substituters
    extra-substituters = [
      # nix community's cache server
      "https://nix-community.cachix.org"
    ];

    # will be appended to the system-level trusted-public-keys
    extra-trusted-public-keys = [
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Principle inputs (updated by `nix run .#update`)

    # Unified Nix sources
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    # Dotfiles
    dotfiles = {
      url = "github:saberzero1/shelter/master";
      flake = false;
    };
    totten = {
      url = "github:saberzero1/totten/master";
      flake = false;
    };
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
