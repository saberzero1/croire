# NixOS System Configuration

Contains system-level configuration for NixOS.

## Structure

- `fonts.nix` - System font configuration
- `security.nix` - Security settings (polkit, rtkit, doas, sudo, PAM, login limits)
- `settings.nix` - NixOS system settings and environment packages

## Purpose

These modules configure system-wide settings that affect the entire NixOS system, including fonts, security policies, authentication, and global packages. Also includes user activation scripts for post-install setup.
