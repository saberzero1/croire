# Programs Directory

Contains application-specific configurations, dotfiles, and custom scripts for various programs and tools used across the system.

## Structure

### Terminal & Shell
- **tmux/**: Terminal multiplexer configuration and session management scripts
- **ranger/**: File manager configuration and custom commands
- **ghostty/**: Terminal emulator configurations for different platforms (Linux, macOS, shared)

### Editors
- **nvim/**: Neovim configuration with Lua scripts, plugins, and custom functionality
- **emacs/**: Emacs configuration files
- **doom/**: Doom Emacs configuration and custom modules
- **zed/**: Zed editor settings and keymaps

### Window Management & Desktop
- **yabai/**: macOS window manager configuration
- **skhd/**: macOS keybinding daemon configuration and scripts
- **amethyst/**: macOS tiling window manager configuration
- **sketchybar/**: macOS menu bar configuration with custom plugins
- **waybar/**: Wayland status bar configuration and scripts

### Development Tools
- **wezterm/**: Terminal emulator configuration with Lua modules
- **neovide/**: Neovim GUI client configuration
- **tmuxinator/**: Tmux session management templates

### System Utilities
- **setup.sh**: System setup and initialization script
- **rclone/**: Cloud sync configuration
- **codespaces/**: GitHub Codespaces specific configurations

### Assets
- **assets/icons/**: Custom icons for system applications and status indicators
- **assets/backgrounds/**: Background images and wallpapers

## Platform-Specific Configurations

Many programs have platform-specific subdirectories:
- **linux/**: Linux-specific configurations
- **macos/**: macOS-specific configurations  
- **shared/**: Cross-platform configurations

## Usage

Configurations in this directory are linked to the appropriate locations in the system through the Nix modules and Home Manager configurations.