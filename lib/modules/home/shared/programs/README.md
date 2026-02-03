# Shared User Programs

Configures cross-platform user programs.

> **Note**: Many of these modules are superseded by feature modules in `modules/_features/`.
> The feature modules provide the same functionality but are designed for selective import.
> This legacy structure is kept for backwards compatibility with the `homeModules.base` module.

## Migration Status

| Feature Module | Supersedes |
|----------------|------------|
| `homeModules.git` | (git config in ssh.nix) |
| `homeModules.shell` | `zsh.nix`, `nushell.nix`, `starship.nix`, `zoxide.nix`, `direnv.nix`, `fzf.nix`, `carapace.nix` |
| `homeModules.editors` | `helix.nix`, `emacs.nix` (imports `nvf/`, `lazyvim/`) |
| `homeModules.terminal` | `tmux.nix`, `tmux-sessionizer.nix` |
| `homeModules.development` | `bat.nix`, `eza.nix`, `ripgrep.nix`, `yazi.nix`, `btop.nix`, `languages/*` |

## Categories

- **Editors**: Neovim (via LazyVim and nvf), Helix, Emacs
- **Shell Tools**: bat, fzf, zsh, starship, tmux, direnv, zoxide
- **File Management**: yazi, ranger, eza
- **Development**: Git (via SSH), vscode, ripgrep, jq
- **Cloud**: rclone

## Structure

- Individual program configuration files at root level
- `lazyvim/` and `nvf/` subdirectories for complex Neovim configurations (imported by feature modules)

## Purpose

Provides consistent tool configurations across all systems, ensuring the same development environment whether on NixOS or macOS.
