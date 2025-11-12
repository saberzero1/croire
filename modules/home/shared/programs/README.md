# Shared User Programs

Configures cross-platform user programs.

## Categories

- **Editors**: Neovim (via LazyVim and nvf), Helix, Emacs
- **Shell Tools**: bat, fzf, zsh, starship, tmux, direnv, zoxide
- **File Management**: yazi, ranger, eza
- **Development**: Git (via SSH), vscode, ripgrep, jq
- **Cloud**: rclone

## Structure

- Individual program configuration files at root level
- `lazyvim/` and `nvf/` subdirectories for complex Neovim configurations

## Purpose

Provides consistent tool configurations across all systems, ensuring the same development environment whether on NixOS or macOS.
