# Copilot Instructions for Croire

## Repository Overview

Croire is a unified NixOS configuration repository that manages system configurations for NixOS and macOS (via nix-darwin) systems. It uses Nix flakes for declarative and reproducible system management.

## Technologies & Tools

- **Nix**: Functional package manager and build system
- **NixOS**: Linux distribution based on Nix
- **nix-darwin**: Nix-based system configuration for macOS
- **Home Manager**: User environment and dotfiles management
- **flake-parts**: Modular flake framework
- **just**: Command runner (alternative to make)
- **omnix (om)**: Nix CLI tool for building and managing configurations

## Repository Structure

- `configurations/`: System-specific configurations
  - `nixos/`: NixOS system configurations
  - `darwin/`: macOS system configurations (using nix-darwin)
  - `home/`: Home Manager user configurations
- `modules/`: Reusable NixOS/Darwin/Home Manager modules
  - `nixos/`: NixOS-specific modules
  - `darwin/`: macOS-specific modules
  - `home/`: Home Manager modules
  - `flake/`: Flake-level modules
- `programs/`: Application-specific configurations and dotfiles
- `overlays/`: Nix package overlays for custom/modified packages
- `scripts/`: Helper scripts for system management
- `flake.nix`: Main flake configuration defining inputs and outputs
- `justfile`: Command definitions for common operations

## Development Workflow

### Building and Testing

- **Lint Nix files**: `just lint` (runs `nix fmt`)
- **Check flake**: `just check` (runs `om ci run .#check`)
- **Check all systems**: `just check-all`
- **Update flake inputs**: `just update` (runs `om ci run .#update`)
- **Build with --abort-on-warn** `just build-warn` (runs `om ci run .#build -- --abort-on-warn --show-trace`)
- **Build and activate configuration**:
  - Linux: `just build` (runs `om ci run .#switch`)
  - macOS: `just build` (runs `sudo om ci run .#switch`)

### Common Commands

- `just` or `just default`: List all available commands
- `just dev`: Enter development shell
- `just pull`: Pull latest changes from repository
- `just switch`: Pull and build/activate configuration
- `just clean-all`: Run all cleanup commands (garbage collection, optimize store)

## Code Style & Conventions

### Nix Code

- Use Nix's formatter (`nix fmt`) for consistent code style
- Follow functional programming principles
- Prefer declarative over imperative approaches
- Use `lib` utilities from nixpkgs for common operations
- Keep modules modular and composable

### File Organization

- Place system-wide configurations in `modules/nixos/` or `modules/darwin/`
- Place user-specific configurations in `modules/home/`
- Place application dotfiles and configurations in `programs/`
- Use descriptive names for modules and options

### Module Conventions

- Define clear module options using `mkOption`
- Provide sensible defaults with `mkDefault`
- Use `mkIf` and `mkMerge` for conditional configuration
- Document non-obvious options with descriptions

## Key Inputs & Dependencies

- **nixpkgs**: Main package repository (tracking unstable)
- **home-manager**: User environment management
- **nix-darwin**: macOS system configuration
- **nixos-unified**: Unified configuration framework
- **sops-nix**: Secret management
- **Various program-specific inputs**: See `flake.nix` for full list

## Cachix Caches

The repository uses multiple binary caches for faster builds:

- nixos cache
- nix-community cache
- personal cache (saberzero1.cachix.org)
- hyprland cache
- omnix cache

## Building Changes

When making changes to the configuration:

1. Edit the relevant module or configuration file
2. Run `just lint` to format code
3. Run `just check` to validate the flake
4. Test with `just build` (may require sudo on macOS)
5. Verify the changes work as expected

## Important Notes

- This is a personal system configuration repository
- Changes affect real systems when activated
- Always test configurations before deploying to production systems
- Use `nix flake check` before committing to catch errors early
- The repository supports both Linux (NixOS) and macOS (nix-darwin)
- Configuration is highly modular - look for existing patterns before adding new ones

## Additional Resources

- Main README: See `/README.md` for hash generation and maintenance commands
- Nix documentation: https://nixos.org/manual/nix/stable/
- NixOS manual: https://nixos.org/manual/nixos/stable/
- Home Manager manual: https://nix-community.github.io/home-manager/
