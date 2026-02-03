# Dendritic pattern: System definitions
# This module defines all NixOS and Darwin configurations
{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (inputs) self;

  # Helper to create a NixOS configuration with integrated home-manager
  mkNixosConfig =
    name:
    {
      system,
      user ? null,
      homeConfig ? null,
      modules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        flake = { inherit inputs; };
        inherit inputs;
      };
      modules = [
        # Base NixOS module (legacy - includes all system config)
        config.flake.nixosModules.base
        # Feature modules (new dendritic pattern) - available for selective use:
        # config.flake.nixosModules.system  # Consolidated system settings
        # Host-specific configuration
        (self + /hosts/nixos/${name}.nix)
        # Home-manager integration (if user specified)
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ (
        if user != null && homeConfig != null then
          [
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  flake = { inherit inputs; };
                  inherit inputs;
                };
                users.${user} = {
                  imports = [
                    # Base home-manager module (legacy - includes all home config)
                    config.flake.homeModules.base
                    config.flake.homeModules.linux-only
                    # Feature modules available for selective use (instead of base):
                    # config.flake.homeModules.git
                    # config.flake.homeModules.shell
                    # config.flake.homeModules.editors
                    # config.flake.homeModules.terminal
                    # config.flake.homeModules.development
                    # config.flake.homeModules.services
                    # User-specific configuration
                    homeConfig
                  ];
                };
              };
            }
          ]
        else
          [ ]
      )
      ++ modules;
    };

  # Helper to create a Darwin configuration with integrated home-manager
  mkDarwinConfig =
    name:
    {
      system,
      user ? null,
      homeConfig ? null,
      modules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        flake = { inherit inputs; };
        inherit inputs;
      };
      modules = [
        # Base Darwin module (legacy - includes all system config)
        config.flake.darwinModules.base
        # Feature modules (new dendritic pattern) - available for selective use:
        # config.flake.darwinModules.system  # Consolidated system settings
        # Host-specific configuration
        (self + /hosts/darwin/${name}.nix)
        # Home-manager integration (if user specified)
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ (
        if user != null && homeConfig != null then
          [
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  flake = { inherit inputs; };
                  inherit inputs;
                };
                users.${user} = {
                  imports = [
                    # Base home-manager module (legacy - includes all home config)
                    config.flake.homeModules.base
                    config.flake.homeModules.darwin-only
                    # Feature modules available for selective use (instead of base):
                    # config.flake.homeModules.git
                    # config.flake.homeModules.shell
                    # config.flake.homeModules.editors
                    # config.flake.homeModules.terminal
                    # config.flake.homeModules.development
                    # config.flake.homeModules.services
                    # User-specific configuration
                    homeConfig
                  ];
                };
              };
            }
          ]
        else
          [ ]
      )
      ++ modules;
    };

  # Helper to create a Home Manager configuration (standalone)
  mkHomeConfig =
    name:
    {
      system,
      modules ? [ ],
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = lib.attrValues config.flake.overlays;
      };
      extraSpecialArgs = {
        flake = { inherit inputs; };
        inherit inputs;
      };
      modules = [
        # Base home-manager module (legacy - includes all home config)
        config.flake.homeModules.base
        # Feature modules available for selective use (instead of base):
        # config.flake.homeModules.git
        # config.flake.homeModules.shell
        # config.flake.homeModules.editors
        # config.flake.homeModules.terminal
        # config.flake.homeModules.development
        # config.flake.homeModules.services
        # User-specific configuration
        (self + /homes/${name}.nix)
      ]
      ++ modules;
    };
in
{
  # Systems supported by this flake
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  flake = {
    # NixOS configurations (with integrated home-manager)
    nixosConfigurations = {
      nixos = mkNixosConfig "nixos" {
        system = "x86_64-linux";
        user = "saberzero1";
        homeConfig = self + /homes/saberzero1.nix;
      };
      nixos-acer = mkNixosConfig "nixos-acer" {
        system = "x86_64-linux";
        user = "saberzero1";
        homeConfig = self + /homes/saberzero1.nix;
      };
    };

    # Darwin configurations (with integrated home-manager)
    darwinConfigurations = {
      "Emiles-MacBook-Pro" = mkDarwinConfig "Emiles-MacBook-Pro" {
        system = "aarch64-darwin";
        user = "emile";
        homeConfig = self + /homes/emile.nix;
      };
    };

    # Standalone Home Manager configurations (for independent use)
    # These allow running home-manager separately from system rebuild
    homeConfigurations = {
      # Darwin user
      "emile" = mkHomeConfig "emile" {
        system = "aarch64-darwin";
      };
      # NixOS user
      "saberzero1" = mkHomeConfig "saberzero1" {
        system = "x86_64-linux";
      };
    };
  };
}
