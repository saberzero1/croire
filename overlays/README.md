# Nix Package Overlays

Contains Nix package overlays that modify or extend nixpkgs.

## Purpose

Defines package overlays that override default package versions, add custom build options, or introduce new packages not available in the standard nixpkgs repository.

## Usage

Overlays are automatically applied to the package set and are available throughout the flake configurations.
