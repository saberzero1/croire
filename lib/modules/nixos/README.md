# NixOS Modules

This directory contains NixOS system configuration modules for Linux systems.

## Structure

- `packages/` - System-wide package management
- `services/` - System services configuration
- `system/` - System-level settings (fonts, security, preferences)

## Usage

These modules are automatically imported through `nixosModules.default` and configured via nixos-unified's automatic module discovery.
