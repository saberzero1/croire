# Dendritic feature module: Darwin Desktop configuration
# Provides macOS-specific desktop environment settings
# Exports: homeModules.darwinDesktop
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.darwinDesktop =
    {
      pkgs,
      config,
      lib,
      flake,
      ...
    }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
    in
    lib.mkIf isDarwin {
      # ─────────────────────────────────────────────────────────────────────────
      # macOS-specific settings
      # ─────────────────────────────────────────────────────────────────────────

      # Disable man pages on Darwin (performance optimization)
      manual.manpages.enable = false;

      # ─────────────────────────────────────────────────────────────────────────
      # Programs
      # ─────────────────────────────────────────────────────────────────────────
      programs = {
        # Aerospace - tiling window manager for macOS (disabled by default)
        aerospace = {
          enable = false;
          package = pkgs.aerospace;
          launchd = {
            enable = true;
            keepAlive = true;
          };
          settings = pkgs.lib.importTOML "${self}/programs/aerospace/aerospace.toml";
        };
      };

      # ─────────────────────────────────────────────────────────────────────────
      # macOS Packages
      # ─────────────────────────────────────────────────────────────────────────
      home.packages = with pkgs; [
        # macOS utilities
        fswatch
        dockutil
      ];

      # ─────────────────────────────────────────────────────────────────────────
      # macOS Configuration Files
      # ─────────────────────────────────────────────────────────────────────────
      home.file = {
        # Aerospace tiling window manager config
        "aerospace-config" = {
          target = ".config/aerospace/aerospace.toml";
          source = "${self}/programs/aerospace/aerospace.toml";
        };

        # Shared assets (backgrounds)
        backgrounds = {
          target = ".assets/backgrounds";
          source = "${self}/assets/backgrounds";
          recursive = true;
        };
      };
    };
}
