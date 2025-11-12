# Home Manager Modules

This directory contains Home Manager configuration modules for user-level settings and dotfiles.

## Structure

- `darwin/` - macOS-specific user configurations
- `nixos/` - NixOS-specific user configurations
- `shared/` - Shared configurations used across all platforms

## Usage

Home Manager modules are automatically discovered and imported based on the target platform. Shared modules are imported on all platforms, while platform-specific modules only load on their respective systems.
