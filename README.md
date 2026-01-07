# Croire <img align="right" src="Croire7.png" alt="Croire Logo">

A unified NixOS configuration repository that manages system configurations for both NixOS and macOS (via nix-darwin) using Nix flakes for declarative and reproducible system management.

## Repository Structure

- **`configurations/`**: System-specific configurations
  - `nixos/`: NixOS system configurations
  - `darwin/`: macOS system configurations (using nix-darwin)
  - `home/`: Home Manager user configurations
- **`modules/`**: Reusable NixOS/Darwin/Home Manager modules
  - `nixos/`: NixOS-specific modules
  - `darwin/`: macOS-specific modules
  - `home/`: Home Manager modules
  - `flake/`: Flake-level modules
- **`programs/`**: Application-specific configurations and dotfiles
- **`overlays/`**: Nix package overlays for custom/modified packages
- **`scripts/`**: Helper scripts for system management
- **`flake.nix`**: Main flake configuration defining inputs and outputs
- **`justfile`**: Command definitions for common operations

## Technologies & Tools

- **Nix**: Functional package manager and build system
- **NixOS**: Linux distribution based on Nix
- **nix-darwin**: Nix-based system configuration for macOS
- **Home Manager**: User environment and dotfiles management
- **flake-parts**: Modular flake framework
- **just**: Command runner (alternative to make)
- **omnix (om)**: Nix CLI tool for building and managing configurations
- **sash**: SSH connection manager for modularized bash configurations

## Usage

### Common Commands

- **Build the configuration**:

  ```shell
  om ci run .#build
  ```

- **Update flake inputs**:

  ```shell
  om ci run .#update
  ```

- **Format Nix files**:

  ```shell
  just lint
  ```

- **Activate the configuration**:

  ```shell
  om ci run .#switch
  ```

- **Clean and garbage collect**:
  ```shell
  om ci run .#clean
  ```

### Additional Commands

- **Check flake validity**:

  ```shell
  just check
  ```

- **Pull latest changes and activate**:

  ```shell
  just switch
  ```

- **Enter development shell**:

  ```shell
  just dev
  ```

- **List all available commands**:
  ```shell
  just
  ```

## Maintenance

### Cleaning

- **Garbage collect unused packages**:

  ```shell
  just gc
  ```

- **Optimize Nix store**:

  ```shell
  just optimize
  ```

- **Run all cleanup commands**:
  ```shell
  just clean-all
  ```
