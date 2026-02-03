# Dendritic pattern: Home Manager module registry
# Bridges old module structure with new dendritic pattern
# Collects all home-manager modules into flake.homeModules
{ inputs, lib, ... }:
let
  inherit (inputs) self;

  # Feature modules - unified configurations that work across platforms
  # Located in ./_features/ to avoid auto-import by import-tree (paths with /_ are ignored)
  featureModules = {
    git = import ./_features/git.nix { inherit inputs lib; };
    shell = import ./_features/shell.nix { inherit inputs lib; };
    editors = import ./_features/editors.nix { inherit inputs lib; };
    terminal = import ./_features/terminal.nix { inherit inputs lib; };
    development = import ./_features/development.nix { inherit inputs lib; };
    services = import ./_features/services.nix { inherit inputs lib; };
    # Platform-specific desktop environments
    linuxDesktop = import ./_features/linux-desktop.nix { inherit inputs lib; };
    darwinDesktop = import ./_features/darwin-desktop.nix { inherit inputs lib; };
  };
in
{
  # Export all home-manager modules
  flake.homeModules = {
    # Legacy base modules
    base = self + /lib/modules/home;
    darwin-only = self + /lib/modules/home/darwin-only.nix;
    linux-only = self + /lib/modules/home/linux-only.nix;

    # Feature modules (new dendritic pattern)
    inherit (featureModules.git.flake.homeModules) git;
    inherit (featureModules.shell.flake.homeModules) shell;
    inherit (featureModules.editors.flake.homeModules) editors;
    inherit (featureModules.terminal.flake.homeModules) terminal;
    inherit (featureModules.development.flake.homeModules) development;
    inherit (featureModules.services.flake.homeModules) services;
    # Platform-specific desktop environments
    inherit (featureModules.linuxDesktop.flake.homeModules) linuxDesktop;
    inherit (featureModules.darwinDesktop.flake.homeModules) darwinDesktop;
  };
}
