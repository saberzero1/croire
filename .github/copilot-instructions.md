# Copilot Instructions for Croire

## Repository Overview

Croire is a unified NixOS configuration repository using the **dendritic pattern** for managing system configurations across NixOS and macOS (via nix-darwin). It uses flake-parts with import-tree for automatic module discovery.

## Architecture

This repository uses the [dendritic pattern](https://github.com/mightyiam/dendritic):
- Every `.nix` file in `modules/` is a flake-parts top-level module
- Modules are auto-imported via [import-tree](https://github.com/vic/import-tree)
- Legacy modules are preserved in `lib/modules/` and imported by base modules

## Technologies & Tools

- **Nix**: Functional package manager and build system
- **NixOS**: Linux distribution based on Nix
- **nix-darwin**: Nix-based system configuration for macOS
- **Home Manager**: User environment and dotfiles management
- **flake-parts**: Modular flake framework
- **import-tree**: Automatic module discovery for dendritic pattern
- **just**: Command runner (alternative to make)

## Repository Structure

```
croire/
├── modules/              # Dendritic top-level modules (auto-imported)
│   ├── systems.nix       # Defines all NixOS/Darwin/Home configurations
│   ├── darwin-base.nix   # Exports darwinModules.base
│   ├── nixos-base.nix    # Exports nixosModules.base
│   ├── home-base.nix     # Exports homeModules.{base,darwin-only,linux-only}
│   ├── overlays.nix      # Exports flake.overlays.default
│   ├── per-system.nix    # Defines perSystem (formatter, devShells, packages)
│   └── lib.nix           # Exports flake.lib.croire utilities
├── lib/modules/          # Legacy modules (imported by base modules)
│   ├── darwin/           # Darwin system modules
│   │   ├── dock/         # macOS Dock configuration
│   │   ├── packages/     # Homebrew packages (casks, formulae, masApps, taps)
│   │   ├── services/     # System services
│   │   └── system/       # System settings (fonts, security, preferences)
│   ├── nixos/            # NixOS system modules
│   │   ├── packages/     # System packages
│   │   ├── services/     # System services
│   │   └── system/       # System settings
│   ├── home/             # Home-manager modules
│   │   ├── shared/       # Cross-platform (editors, shell, languages)
│   │   ├── darwin/       # macOS-specific
│   │   └── nixos/        # NixOS-specific (Wayland, Hyprland)
│   └── flake/            # Flake utilities (templates, lib)
├── hosts/                # Host-specific configurations
│   ├── darwin/           # macOS hosts
│   └── nixos/            # NixOS hosts
├── homes/                # Standalone home-manager configurations
├── programs/             # Application dotfiles and configurations
├── overlays/             # Nix package overlays
├── configurations/       # Legacy configurations (referenced by hosts/)
├── scripts/              # Helper scripts
├── flake.nix             # Main flake (flake-parts + import-tree)
└── justfile              # Command definitions
```

## Flake Outputs

| Output | Description |
|--------|-------------|
| `darwinConfigurations.Emiles-MacBook-Pro` | macOS system |
| `nixosConfigurations.{nixos,nixos-acer}` | NixOS systems |
| `homeConfigurations.{emile,saberzero1}` | Standalone home-manager |
| `overlays.default` | Package overlays |
| `lib.croire.*` | Utility functions |

## Development Workflow

### Building and Testing

- **Format Nix files**: `just lint` (runs `nix fmt`)
- **Check flake**: `just check` (runs `nix flake check`)
- **Check all systems**: `just check-all`
- **Update flake inputs**: `just update`
- **Build and activate**:
  - Linux: `just build`
  - macOS: `just build`

### Home Manager (Standalone)

```shell
# Build
nix build .#homeConfigurations.emile.activationPackage

# Build and activate
just home-switch emile
```

### Common Commands

- `just` - List all available commands
- `just dev` - Enter development shell
- `just switch` - Pull and build/activate
- `just clean-all` - Full cleanup
- `just configs` - List available configurations

## Code Style & Conventions

### Dendritic Modules

New features should be added as flake-parts modules in `modules/`:

```nix
# modules/my-feature.nix
{ inputs, config, ... }:
{
  flake.darwinModules.myFeature = { ... }: {
    # Darwin configuration
  };

  flake.nixosModules.myFeature = { ... }: {
    # NixOS configuration
  };
}
```

### Legacy Modules

Existing modules in `lib/modules/` follow the old pattern with `{ flake, pkgs, ... }` arguments. These are imported by the dendritic base modules.

### Nix Code Style

- Use `nix fmt` for consistent formatting
- Follow functional programming principles
- Prefer declarative over imperative approaches
- Use `lib` utilities from nixpkgs

### File Organization

- **New features**: Add to `modules/` as flake-parts modules
- **Host-specific settings**: Add to `hosts/{darwin,nixos}/`
- **User settings**: Add to `homes/` or `lib/modules/home/`
- **Dotfiles**: Add to `programs/`

## Key Inputs & Dependencies

- **nixpkgs**: Main package repository (tracking unstable)
- **flake-parts**: Modular flake framework
- **import-tree**: Automatic module discovery
- **home-manager**: User environment management
- **nix-darwin**: macOS system configuration
- **sops-nix**: Secret management

## Library Functions

Available via `flake.lib.croire`:

- `autoImport dir` - Import all `.nix` files in directory
- `filesAsNames dir` - Get filenames without `.nix` extension
- `filesAsStrings dir` - Read file contents as strings
- `autoImportRecursive dir` - Recursively import all `.nix` files
- `overrideLicense pkg` - Override package license

## Binary Caches

- `cache.nixos.org` - Official NixOS
- `nix-community.cachix.org` - Community packages
- `saberzero1.cachix.org` - Personal builds
- `hyprland.cachix.org` - Hyprland
- `om.cachix.org` - Omnix
- `sash.cachix.org` - Sash

## Important Notes

- This uses the **dendritic pattern** - every file in `modules/` is auto-imported
- Legacy modules in `lib/modules/` are preserved for compatibility
- Host configurations are in `hosts/`, not `configurations/`
- Home-manager has standalone outputs (`homeConfigurations`)
- Always run `nix flake check` before committing

## Additional Resources

- [Dendritic Pattern](https://github.com/mightyiam/dendritic)
- [import-tree](https://github.com/vic/import-tree)
- [flake-parts](https://flake.parts/)
- [Nix documentation](https://nixos.org/manual/nix/stable/)
- [Home Manager manual](https://nix-community.github.io/home-manager/)
