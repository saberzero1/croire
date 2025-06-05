############################################################################
#
#  Nix commands related to the local machine
#
############################################################################
set quiet

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
build:
  df -H --output=pcent,avail,target | grep \/$ | sed "s# \/##" | sed "s#% *#%#g" | sed "s#^#Disk usage:#" | sed "s#%#% (#" | sed "s#\$# available)#"
  nix run --accept-flake-config .#activate
  echo "Installing Neovim plugins"
  nvim --headless "+Lazy! restore" "+Lazy! clean" "+qa" 1>/dev/null
  echo "Installing Neovim plugins done"

# Activate default configuration
[group('Main')]
[macos]
build:
  # skhd --stop-service || true
  sudo nix run --accept-flake-config .#activate
  echo "Installing Neovim plugins"
  nvim --headless "+Lazy! restore" "+Lazy! clean" "+qa" 1>/dev/null
  echo "Installing Neovim plugins done"
  sketchybar --reload
  # skhd --start-service

# Activate default configuration
[group('Main')]
[linux]
switch: pull build

# Activate default configuration
[group('Main')]
[macos]
switch: pull build

# Initialize the configuration
[group('Main')]
[unix]
pull-dotfiles:
  git -C ~/Repos/shelter pull || git clone https://github.com/saberzero1/shelter.git ~/Repos/shelter

# Initialize the configuration
[group('Main')]
[unix]
pull-self:
  git fetch --all
  git pull 2>/dev/null

# Initialize the configuration
[group('Main')]
[unix]
pull: pull-self

# Check the system configuration
[group('Main')]
status:
  sudo nix-channel --list | grep nixos

[group('Util')]
upp input:
  nix flake lock --update-input {{input}}

[group('Util')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[group('Util')]
repl:
  nix repl -f flake:nixpkgs

[group('Util')]
disk:
  df -H --output=source,fstype,size,used,avail,pcent,target

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

