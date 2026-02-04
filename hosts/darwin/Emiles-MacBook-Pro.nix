# Host: Emiles-MacBook-Pro (Darwin)
# Dendritic pattern: Host-specific configuration
{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # The platform the configuration will be used on
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
    overlays = lib.attrValues (self.overlays or { });
  };

  networking = {
    hostName = "Emiles-MacBook-Pro";
    applicationFirewall.enable = true;
  };

  # User setup
  users.users."emile".home = "/Users/emile";

  # System settings
  system = {
    primaryUser = "emile";
    stateVersion = 6;
    startup.chime = false;
  };

  # Touch ID for sudo
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  # Dock configuration is set in modules/_features/darwin-system.nix

  # Trusted users for Nix
  nix.settings.trusted-users = [
    "root"
    "emile"
  ];
  determinateNix.customSettings.trusted-users = [
    "root"
    "emile"
  ];
}
