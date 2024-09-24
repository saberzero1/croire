# just is a command runner, Justfile is very similar to Makefile, but simpler.
# Shamelessly stolen from https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

fetch:
  git submodule update --init --remote --recursive

build:
  sudo nixos-rebuild build --flake ./croire/. --impure --use-remote-sudo

test:
  sudo nixos-rebuild test --flake ./croire/. --impure --use-remote-sudo

switch:
  sudo nixos-rebuild switch --flake ./croire/. --impure --use-remote-sudo

debug:
  nixos-rebuild switch --flake ./croire/. --impure --use-remote-sudo --show-trace --verbose --option eval-cache false

update:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp input:
  nix flake lock --update-input {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean-old:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage -d

clean:
  # remove all old generations from boot
  sudo /run/current-system/bin/switch-to-configuration boot

optimize:
  # hard link nix stores
  sudo nix store optimise

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
