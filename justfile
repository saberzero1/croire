# just is a command runner, Justfile is very similar to Makefile, but simpler.
# Shamelessly stolen from https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands

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
[group('dev')]
lint:
  nix fmt

# Check nix flake
[group('dev')]
check:
  nix flake check

[group('dev')]
check-all:
  nix flake check --all-systems

# Manually enter dev shell
[group('dev')]
dev:
  nix develop

# Activate the configuration
[group('Main')]
run:
  nix run

# Activate default configuration
[group('Main')]
switch:
  nix run .#activate --accept-flake-config

# Check the system configuration
[group('Main')]
status:
  sudo nix-channel --list | grep nixos

#fetch:
#  git submodule update --init --remote --recursive

#dinit:
#  nix run nix-darwin -- switch --flake .

#[linux]
#build:
#  sudo nixos-rebuild build --flake . --impure --use-remote-sudo

#[macos]
#build:
#  sudo -s -u $(whoami) darwin-rebuild build --flake . --impure

#[linux]
#test:
#  sudo nixos-rebuild test --flake . --impure --use-remote-sudo

#test
#  sudo -s -u $(whoami) darwin-rebuild test --flake . --impure

#[linux]
#switch:
#  sudo nixos-rebuild switch --flake . --impure --use-remote-sudo

#[macos]
#switch:
#  sudo -s -u $(whoami) darwin-rebuild  switch --flake . --impure

#debug:
#  nixos-rebuild switch --flake . --impure --use-remote-sudo --show-trace --verbose --option eval-cache false

#update:
#  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp input:
  nix flake lock --update-input {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

[unix]
clean-old:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

[unix]
gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage -d

[unix]
clean:
  # remove all old generations from boot
  sudo /run/current-system/bin/switch-to-configuration boot

[unix]
optimize:
  # hard link nix stores
  sudo nix store optimise

[linux]
clean-all:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo nix store optimise
  nix store optimise
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo /run/current-system/bin/switch-to-configuration boot

[macos]
clean-all:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  sudo nix store optimise
  nix store optimise
  sudo nix-collect-garbage -d
  nix-collect-garbage -d

############################################################################
#
#  Idols, Commands related to my remote distributed building cluster
#
############################################################################

# add-idols-ssh-key:
#   ssh-add ~/.ssh/ai-idols
#
# aqua: add-idols-ssh-key
#   nixos-rebuild --flake .#aquamarine --target-host aquamarine --build-host aquamarine switch --use-remote-sudo
#
# aqua-debug: add-idols-ssh-key
#   nixos-rebuild --flake .#aquamarine --target-host aquamarine --build-host aquamarine switch --use-remote-sudo --show-trace --verbose
#
# ruby: add-idols-ssh-key
#   nixos-rebuild --flake .#ruby --target-host ruby --build-host ruby switch --use-remote-sudo
#
# idols: aqua ruby kana
#
# idols-debug: aqua-debug ruby-debug kana-debug
