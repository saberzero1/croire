# Nix Package Overlays

Contains Nix package overlays that modify or extend nixpkgs.

## Purpose

Defines package overlays that override default package versions, add custom build options, or introduce new packages not available in the standard nixpkgs repository.

## Available Overlays

### Custom Packages
- **sash**: SSH connection manager for modularized bash configurations, with custom Home Manager module support
- **omnix**: Nix CLI tool for building and managing configurations (from custom fork)
- **ghostty**: Terminal emulator
- **fh**: FlakeHub CLI tool
- **nix-direnv**: Direnv integration for Nix
- **nixgl**: OpenGL support for Nix packages

### Gaming Packages
- **proton-cachyos**: Proton compatibility layer for gaming
- **procon2-init**: Pro Controller initialization tool

## Usage

Overlays are automatically applied to the package set and are available throughout the flake configurations.
