# Home Manager Modules (Legacy)

This directory contains the legacy Home Manager configuration modules for user-level settings and dotfiles.

> **Note**: This is the legacy module structure imported by `homeModules.base`.
> New feature modules in `modules/_features/` provide the same functionality with better composability.
> See the main README for the migration path.

## Structure

- `darwin/` - macOS-specific user configurations
- `nixos/` - NixOS-specific user configurations  
- `shared/` - Shared configurations used across all platforms

## Feature Module Equivalents

| Legacy Path | Feature Module |
|-------------|----------------|
| `shared/programs/{zsh,nushell,starship,zoxide,direnv,fzf,carapace}.nix` | `homeModules.shell` |
| `shared/programs/{helix,emacs,nvf,lazyvim}.nix` | `homeModules.editors` |
| `shared/programs/{tmux,tmux-sessionizer}.nix` | `homeModules.terminal` |
| `shared/programs/{bat,eza,ripgrep,yazi,btop}.nix` | `homeModules.development` |
| `shared/languages/*` | `homeModules.development` |
| `*/services/*` | `homeModules.services` |

## Usage

Home Manager modules are automatically discovered and imported based on the target platform. Shared modules are imported on all platforms, while platform-specific modules only load on their respective systems.

### Using Legacy (current default)

```nix
imports = [ inputs.croire.homeModules.base ];
```

### Using Feature Modules (recommended for new configs)

```nix
imports = [
  inputs.croire.homeModules.git
  inputs.croire.homeModules.shell
  inputs.croire.homeModules.editors
  inputs.croire.homeModules.terminal
  inputs.croire.homeModules.development
  inputs.croire.homeModules.services
];
```
