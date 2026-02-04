# Croire <img align="right" src="Croire7.png" alt="Croire Logo">

A unified NixOS configuration repository using the **dendritic pattern** for managing system configurations across NixOS and macOS (via nix-darwin) with Nix flakes.

## Architecture

This repository uses the [dendritic pattern](https://github.com/mightyiam/dendritic) with [import-tree](https://github.com/vic/import-tree) for automatic module discovery. Every `.nix` file in `modules/` is a flake-parts top-level module that gets auto-imported. Files in directories prefixed with `_` (like `_features/`) are excluded from auto-import.

## Repository Structure

```
croire/
├── modules/              # Dendritic top-level modules (auto-imported by import-tree)
│   ├── systems.nix       # Defines all NixOS/Darwin/Home configurations
│   ├── darwin-base.nix   # Registry: exports darwinModules.*
│   ├── nixos-base.nix    # Registry: exports nixosModules.*
│   ├── home-base.nix     # Registry: exports homeModules.*
│   ├── overlays.nix      # Exports flake.overlays.default
│   ├── per-system.nix    # Defines perSystem (formatter, devShells, packages)
│   ├── lib.nix           # Exports flake.lib.croire utilities
│   │
│   └── _features/        # Feature modules (excluded from auto-import)
│       ├── _imports/         # Shared imports for feature modules
│       │   ├── darwin/       # Darwin-specific imports (dock, packages)
│       │   ├── fonts.nix     # Shared font configuration
│       │   ├── languages/    # Language toolchains
│       │   ├── lazyvim/      # LazyVim configuration
│       │   └── nvf/          # NVF neovim configuration
│       ├── git.nix           # homeModules.git
│       ├── shell.nix         # homeModules.shell
│       ├── editors.nix       # homeModules.editors
│       ├── terminal.nix      # homeModules.terminal
│       ├── development.nix   # homeModules.development
│       ├── services.nix      # homeModules.services
│       ├── darwin-system.nix # darwinModules.system
│       └── nixos-system.nix  # nixosModules.system
│
├── hosts/                # Host-specific configurations
│   ├── darwin/           # macOS hosts (e.g., Emiles-MacBook-Pro.nix)
│   └── nixos/            # NixOS hosts (e.g., nixos.nix, nixos-acer.nix)
├── homes/                # Standalone home-manager configurations
│   ├── emile.nix         # Darwin user
│   └── saberzero1.nix    # NixOS user
├── programs/             # Application-specific dotfiles and configurations
├── overlays/             # Nix package overlays
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

### Module Outputs

#### Darwin Modules (`darwinModules.*`)

| Module | Description |
|--------|-------------|
| `darwinModules.system` | Consolidated system config (fonts, security, settings, packages, dock) |

#### NixOS Modules (`nixosModules.*`)

| Module | Description |
|--------|-------------|
| `nixosModules.system` | Consolidated system config (fonts, security, hardware, services) |

#### Home Manager Modules (`homeModules.*`)

Feature-based modules that work across Darwin and NixOS:

| Module | Description |
|--------|-------------|
| `homeModules.git` | Git, lazygit, gh, diff-so-fancy |
| `homeModules.shell` | Zsh, nushell, starship, zoxide, direnv, fzf, carapace |
| `homeModules.editors` | Neovim (nvf/lazyvim), helix, emacs |
| `homeModules.terminal` | Tmux, ghostty, wezterm |
| `homeModules.development` | Languages, bat, eza, ripgrep, yazi, btop |
| `homeModules.services` | Espanso, emacs daemon, mako, wlsunset |
| `homeModules.xdg` | XDG config, MIME apps, desktop entries |
| `homeModules.linuxDesktop` | Hyprland, Wayland, GTK (Linux only) |
| `homeModules.darwinDesktop` | Aerospace, dock (macOS only) |

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
2. **Automatic importing**: `import-tree` discovers and imports all modules (except `/_` paths)
3. **Feature-based organization**: Each feature module implements a single concern
4. **Cross-cutting concerns**: Features can span multiple configuration types

### Module Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│ modules/                                                         │
│ ├── systems.nix       ← Defines host configurations             │
│ ├── darwin-base.nix   ← Registry for darwinModules.*            │
│ ├── nixos-base.nix    ← Registry for nixosModules.*             │
│ ├── home-base.nix     ← Registry for homeModules.*              │
│ └── _features/        ← Feature module implementations          │
│     ├── _imports/     ← Shared imports (fonts, languages, etc.) │
│     ├── git.nix       → homeModules.git                         │
│     ├── shell.nix     → homeModules.shell                       │
│     ├── editors.nix   → homeModules.editors                     │
│     └── ...                                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Adding a New Feature Module

1. Create a new file in `modules/_features/`:

```nix
# modules/_features/my-feature.nix
{ inputs, lib, ... }:
let
  inherit (inputs) self;
in
{
  flake.homeModules.myFeature = { pkgs, config, lib, ... }:
  let
    inherit (pkgs.stdenv) isDarwin isLinux;
  in
  {
    programs.myProgram = {
      enable = true;
      # Platform-specific settings
      extraConfig = lib.optionalString isDarwin "darwin-specific";
    };
  };
}
```

2. Register it in `modules/home-base.nix`:

```nix
featureModules = {
  # ... existing modules
  myFeature = import ./_features/my-feature.nix { inherit inputs lib; };
};

flake.homeModules = {
  # ... existing exports
  inherit (featureModules.myFeature.flake.homeModules) myFeature;
};
```

### Using Feature Modules

Feature modules can be imported selectively in your configuration:

```nix
# In your home-manager configuration (external flake)
{
  imports = [
    inputs.croire.homeModules.git
    inputs.croire.homeModules.shell
    inputs.croire.homeModules.editors
  ];
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
