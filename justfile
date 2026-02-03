############################################################################
#
#  Croire - Dendritic NixOS/Darwin Configuration
#  Commands for building, updating, and managing the system
#
############################################################################
set quiet

# Default command when 'just' is run without arguments
default:
  @just --list

############################################################################
# Main Commands
############################################################################

# Update nix flake inputs
[group('Main')]
update:
  nix flake update

# Update with GitHub token (for rate limiting)
[group('Main')]
update-with-token:
  nix flake update --option access-tokens "github.com=$(gh auth token)"

# Activate the configuration (nix run)
[group('Main')]
run:
  nix run

# Activate default configuration (Linux)
[group('Main')]
[linux]
build:
  @echo "Building NixOS configuration..."
  nix build .#nixosConfigurations.$(hostname).config.system.build.toplevel --show-trace
  @echo "Activating configuration..."
  sudo nixos-rebuild switch --flake .#$(hostname)

# Activate default configuration (macOS)
[group('Main')]
[macos]
build:
  @echo "Building Darwin configuration..."
  nix build .#darwinConfigurations.$(hostname -s).system --show-trace
  @echo "Activating configuration..."
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#$(hostname -s)

# Pull and build
[group('Main')]
[unix]
switch: pull build

# Pull latest changes
[group('Main')]
[unix]
pull:
  git fetch --all
  git pull 2>/dev/null || true

############################################################################
# Home Manager Commands
############################################################################

# Build home-manager configuration
[group('Home')]
home-build user="emile":
  nix build .#homeConfigurations.{{user}}.activationPackage

# Activate home-manager configuration
[group('Home')]
home-switch user="emile":
  nix build .#homeConfigurations.{{user}}.activationPackage
  ./result/activate

# List available home configurations
[group('Home')]
home-list:
  nix eval .#homeConfigurations --apply 'x: builtins.attrNames x' 2>/dev/null

############################################################################
# Development Commands
############################################################################

# Lint/format nix files
[group('Dev')]
lint:
  nix fmt

# Check nix flake
[group('Dev')]
check:
  nix flake check

# Check nix flake for all systems
[group('Dev')]
check-all:
  nix flake check --all-systems

# Enter development shell
[group('Dev')]
dev:
  nix develop

# Build with warnings as errors
[group('Dev')]
build-warn:
  nix build .#darwinConfigurations.$(hostname -s).system -- --abort-on-warn --show-trace

# Open Nix REPL with nixpkgs
[group('Dev')]
repl:
  nix repl -f flake:nixpkgs

# Show flake info
[group('Dev')]
info:
  nix flake show

# Show flake metadata
[group('Dev')]
metadata:
  nix flake metadata

############################################################################
# Utility Commands
############################################################################

# Update a single input
[group('Util')]
upp input:
  nix flake lock --update-input {{input}}

# Show system profile history
[group('Util')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Show disk usage
[group('Util')]
[linux]
disk:
  df -H --output=source,fstype,size,used,avail,pcent,target

[group('Util')]
[macos]
disk:
  df -H

# Check NixOS channel status
[group('Util')]
[linux]
status:
  sudo nix-channel --list | grep nixos || echo "No NixOS channels configured (using flakes)"

# List available configurations
[group('Util')]
configs:
  @echo "Darwin configurations:"
  @nix eval .#darwinConfigurations --apply 'x: builtins.attrNames x' 2>/dev/null || echo "  (none)"
  @echo "NixOS configurations:"
  @nix eval .#nixosConfigurations --apply 'x: builtins.attrNames x' 2>/dev/null || echo "  (none)"
  @echo "Home configurations:"
  @nix eval .#homeConfigurations --apply 'x: builtins.attrNames x' 2>/dev/null || echo "  (none)"

############################################################################
# Cleanup Commands
############################################################################

# Remove all generations older than 7 days
[group('Clean')]
[unix]
clean-old:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collect all unused nix store entries
[group('Clean')]
[unix]
gc:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d

# Remove old generations
[group('Clean')]
[unix]
clean:
  @echo "Before cleanup:"
  @df -h / | tail -1
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  @echo "After cleanup:"
  @df -h / | tail -1

# Hard link duplicate nix store entries
[group('Clean')]
[unix]
optimize:
  sudo nix store optimise
  nix store optimise

# Run all clean commands (Linux)
[group('Clean')]
[linux]
clean-all: gc optimize
  sudo /run/current-system/bin/switch-to-configuration boot

# Run all clean commands (macOS)
[group('Clean')]
[macos]
clean-all: gc optimize

############################################################################
# Maintenance Commands
############################################################################

# Repair the nix store (slow!)
[group('Maintenance')]
[confirm('This will take a long time. Continue?')]
[unix]
repair:
  sudo nix-store --verify --check-contents --repair

# Verify store integrity (fast)
[group('Maintenance')]
[unix]
verify:
  nix-store --verify

# Pull dotfiles repository
[group('Maintenance')]
[unix]
pull-dotfiles:
  git -C ~/Repos/shelter pull || git clone https://github.com/saberzero1/shelter.git ~/Repos/shelter
