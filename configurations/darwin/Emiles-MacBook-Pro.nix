# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{ flake, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
    self.darwinModules.fonts
    self.darwinModules.homebrew
    self.darwinModules.security
    self.darwinModules.services
    self.darwinModules.system
  ];

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      # allowBroken = true;
      # allowInsecure = false;
      # allowUnsupportedSystem = true;
    };
    overlays = lib.attrValues self.overlays;
  };

  networking.hostName = "Emiles-MacBook-Pro";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."emile".home = "/Users/emile";

  # Enable home-manager for "runner" user
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users."emile" = {
      imports = [ (self + /configurations/home/emile.nix) ];
    };
  };

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  security.pam.enableSudoTouchIdAuth = true;
}
