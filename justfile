############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

# Default command when 'just' is run without arguments
default:
  @just --list

# Update nix flake
[group('Main')]
update:
  nix flake update

# Lint nix files
[group('Dev')]
lint:
  nix fmt -- .

# Check nix flake
[group('Dev')]
check:
  nix flake check

# Check nix flake for all systems
[group('Dev')]
check-all:
  nix flake check --all-systems

# Manually enter dev shell
[group('Dev')]
dev:
  nix develop

# Activate the configuration
[group('Main')]
run:
  nix run

# Activate default configuration
[group('Main')]
[linux]
switch-pure:
  nix run --accept-flake-config .#activate
  sudo chmod +x ~/.config/tmux/scripts/tmux-sessionizer

# Activate default configuration
[group('Main')]
[macos]
switch-pure:
  skhd --stop-service
  nix run --accept-flake-config .#activate
  sudo chmod +x ~/.config/tmux/scripts/tmux-sessionizer
  skhd --start-service

# Activate default configuration
[group('Main')]
[linux]
switch:
  nix run --impure --accept-flake-config .#activate
  sudo chmod +x ~/.config/tmux/scripts/tmux-sessionizer

# Activate default configuration
[group('Main')]
[macos]
switch:
  skhd --stop-service
  nix run --impure --accept-flake-config .#activate
  sudo chmod +x ~/.config/tmux/scripts/tmux-sessionizer
  skhd --start-service

# Check the system configuration
[group('Main')]
status:
  sudo nix-channel --list | grep nixos

upp input:
  nix flake lock --update-input {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

# Remove all generations older than 7 days
[group('Clean')]
[unix]
clean-old:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
[group('Clean')]
[unix]
gc:
  sudo nix-collect-garbage -d

# Remove all old generations from boot
[group('Clean')]
[unix]
clean:
  sudo /run/current-system/bin/switch-to-configuration boot

# Hard link nix stores
[group('Clean')]
[unix]
optimize:
  sudo nix store optimise

# Run all clean commands
[group('Clean')]
[linux]
clean-all:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo nix store optimise
  nix store optimise
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo /run/current-system/bin/switch-to-configuration boot

# Run all clean commands
[group('Clean')]
[macos]
clean-all:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo nix store optimise
  nix store optimise
  sudo nix-collect-garbage -d
  nix-collect-garbage -d

# Repair the nix store
[group('Maintenance')]
[confirm('This will take a long time, are you sure?')]
[unix]
repair:
  sudo nix-store --verify --check-contents --repair

