# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{
  flake,
  pkgs,
  lib,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
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

  networking = {
    hostName = "Emiles-MacBook-Pro";

    applicationFirewall = {
      enable = true;
    };
  };

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."emile".home = "/Users/emile";

  # Enable home-manager for "runner" user
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users."emile" = {
      imports = [ (self + /configurations/home/darwin/emile.nix) ];
    };
    backupFileExtension = "backup";
  };

  # Necessary for using flakes on this system.
  nix = {
    enable = false;
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      extra-nix-path = "nixpkgs=flake:nixpkgs";
      trusted-users = [
        "root"
        "emile"
      ];
      # lazy-trees = true;
      # eval-cores = 0; # Use all available CPU cores for evaluation
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    primaryUser = "emile";
    stateVersion = 6;
    startup.chime = false;
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
