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
        # System feature module (dendritic pattern)
        config.flake.nixosModules.system
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
                    # Feature modules (dendritic pattern)
                    config.flake.homeModules.git
                    config.flake.homeModules.shell
                    config.flake.homeModules.editors
                    config.flake.homeModules.terminal
                    config.flake.homeModules.development
                    config.flake.homeModules.services
                    config.flake.homeModules.xdg
                    # Platform-specific desktop environment
                    config.flake.homeModules.linuxDesktop
                    # Linux-specific external modules (gaming)
                    inputs.geforce-infinity.homeManagerModules.default
                    inputs.play-nix.homeManagerModules.play
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
        # System feature module (dendritic pattern)
        config.flake.darwinModules.system
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
                    # Feature modules (dendritic pattern)
                    config.flake.homeModules.git
                    config.flake.homeModules.shell
                    config.flake.homeModules.editors
                    config.flake.homeModules.terminal
                    config.flake.homeModules.development
                    config.flake.homeModules.services
                    config.flake.homeModules.xdg
                    # Platform-specific desktop environment
                    config.flake.homeModules.darwinDesktop
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
        # Feature modules (dendritic pattern)
        config.flake.homeModules.git
        config.flake.homeModules.shell
        config.flake.homeModules.editors
        config.flake.homeModules.terminal
        config.flake.homeModules.development
        config.flake.homeModules.services
        config.flake.homeModules.xdg
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
