# Darwin Modules

This directory contains nix-darwin system configuration modules for macOS systems.

## Structure

- `dock/` - macOS Dock configuration
- `packages/` - Homebrew package management (casks, formulae, Mac App Store apps, taps)
- `services/` - System services configuration
- `system/` - System-level settings (fonts, security, preferences)

## Usage

These modules are automatically imported through `nixosModules.default` and configured via nixos-unified's automatic module discovery.
