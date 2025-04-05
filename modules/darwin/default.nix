# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    ./dock
    ./packages
    ./services
    ./system
  ];

  # These users can add Nix caches.
  nix = {
    enable = false;
    settings.trusted-users = [
      "root"
      "emile"
    ];
  };

  local = {
    dock.enable = true;
    dock.entries = [
      { path = "/Applications/Wavebox.app"; }
      { path = "/Applications/Ghostty.app"; }
      { path = "/Applications/Obsidian.app"; }
      # { path = "${pkgs.wezterm}/Applications/Wezterm.app"; }
    ];
  };
}
