# Croire <img align="right" src="Croire7.png" alt="Croire Logo">

A unified NixOS configuration repository using the **dendritic pattern** for managing system configurations across NixOS and macOS (via nix-darwin) with Nix flakes.

## Architecture

This repository uses the [dendritic pattern](https://github.com/mightyiam/dendritic) with [import-tree](https://github.com/vic/import-tree) for automatic module discovery. Every `.nix` file in `modules/` is a flake-parts top-level module that gets auto-imported.

## Repository Structure

```
croire/
├── modules/              # Dendritic top-level modules (auto-imported by import-tree)
│   ├── systems.nix       # Defines all NixOS/Darwin/Home configurations
│   ├── darwin-base.nix   # Exports darwinModules.base
│   ├── nixos-base.nix    # Exports nixosModules.base
│   ├── home-base.nix     # Exports homeModules.{base,darwin-only,linux-only}
│   ├── overlays.nix      # Exports flake.overlays.default
│   ├── per-system.nix    # Defines perSystem (formatter, devShells, packages)
│   └── lib.nix           # Exports flake.lib.croire utilities
├── lib/modules/          # Legacy modules (imported by base modules)
│   ├── darwin/           # Darwin system modules (dock, packages, services, system)
│   ├── nixos/            # NixOS system modules (packages, services, system)
│   ├── home/             # Home-manager modules (shared, darwin, nixos)
│   └── flake/            # Flake utilities (templates, etc.)
├── hosts/                # Host-specific configurations
│   ├── darwin/           # macOS hosts (e.g., Emiles-MacBook-Pro.nix)
│   └── nixos/            # NixOS hosts (e.g., nixos.nix, nixos-acer.nix)
├── homes/                # Standalone home-manager configurations
│   ├── emile.nix         # Darwin user
│   └── saberzero1.nix    # NixOS user
├── programs/             # Application-specific dotfiles and configurations
├── overlays/             # Nix package overlays
├── configurations/       # Legacy configurations (referenced by hosts/)
├── scripts/              # Helper scripts
├── flake.nix             # Main flake using flake-parts + import-tree
└── justfile              # Command definitions
```

## Flake Outputs

| Output | Description |
|--------|-------------|
| `darwinConfigurations.Emiles-MacBook-Pro` | macOS system configuration |
| `nixosConfigurations.nixos` | NixOS desktop configuration |
| `nixosConfigurations.nixos-acer` | NixOS laptop configuration |
| `homeConfigurations.emile` | Standalone home-manager (Darwin) |
| `homeConfigurations.saberzero1` | Standalone home-manager (NixOS) |
| `overlays.default` | Package overlays |
| `lib.croire.*` | Utility functions |

## Technologies & Tools

- **Nix**: Functional package manager and build system
- **NixOS**: Linux distribution based on Nix
- **nix-darwin**: Nix-based system configuration for macOS
- **Home Manager**: User environment and dotfiles management
- **flake-parts**: Modular flake framework
- **import-tree**: Automatic module discovery for dendritic pattern
- **just**: Command runner (alternative to make)
- **omnix (om)**: Nix CLI tool for building and managing configurations

## Usage

### Quick Start

```shell
# Build and activate system configuration
just build

# Update flake inputs
just update

# Enter development shell
just dev
```

### System Commands

| Command | Description |
|---------|-------------|
| `just build` | Build and activate system configuration |
| `just switch` | Pull latest changes and activate |
| `just update` | Update all flake inputs |
| `just check` | Check flake validity |
| `just check-all` | Check flake for all systems |

### Home Manager (Standalone)

```shell
# Build home-manager configuration
nix build .#homeConfigurations.emile.activationPackage

# Activate home-manager
nix run .#homeConfigurations.emile.activationPackage
```

### Development

| Command | Description |
|---------|-------------|
| `just dev` | Enter development shell |
| `just lint` | Format Nix files |
| `just repl` | Open Nix REPL |
| `just build-warn` | Build with warnings as errors |

### Maintenance

| Command | Description |
|---------|-------------|
| `just gc` | Garbage collect unused packages |
| `just optimize` | Hard-link duplicate store paths |
| `just clean` | Remove old generations |
| `just clean-all` | Full cleanup (gc + optimize) |
| `just repair` | Repair Nix store (slow) |

## Dendritic Pattern

The dendritic pattern organizes configuration by **feature** rather than platform hierarchy:

1. **Every file is a module**: All `.nix` files in `modules/` are flake-parts modules
2. **Automatic importing**: `import-tree` discovers and imports all modules
3. **Feature-based organization**: Each file implements a single feature
4. **Cross-cutting concerns**: Features can span multiple configuration types

### Adding a New Feature

Create a new file in `modules/`:

```nix
# modules/my-feature.nix
{ inputs, config, ... }:
{
  # Export to flake outputs
  flake.darwinModules.myFeature = { ... }: {
    # Darwin-specific configuration
  };

  flake.nixosModules.myFeature = { ... }: {
    # NixOS-specific configuration
  };
}
```

### Library Functions

Available via `flake.lib.croire`:

- `autoImport dir` - Import all `.nix` files in a directory
- `filesAsNames dir` - Get filenames without `.nix` extension
- `filesAsStrings dir` - Read file contents as strings
- `autoImportRecursive dir` - Recursively import all `.nix` files
- `overrideLicense pkg` - Override package license metadata

## Binary Caches

This flake uses multiple binary caches for faster builds:

- `cache.nixos.org` - Official NixOS cache
- `nix-community.cachix.org` - Nix community packages
- `saberzero1.cachix.org` - Personal builds
- `hyprland.cachix.org` - Hyprland packages
- `om.cachix.org` - Omnix packages
- `sash.cachix.org` - Sash packages
