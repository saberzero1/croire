{
  flake,
  lib,
  config,
  ...
}:
let
  inherit (flake) inputs;
in
{
  # Import the play.nix NixOS module
  imports = [
    inputs.play-nix.nixosModules.play
  ];

  # play.nix module provides the following options:
  # - play.amd.enable = true;           # AMD GPU optimization via LACT daemon
  # - play.steam.enable = true;         # Steam with Proton-CachyOS
  # - play.lutris.enable = true;        # Lutris game manager
  # - play.gamemode.enable = true;      # Performance optimization
  # - play.ananicy.enable = true;       # Process scheduling
  # - play.procon2.enable = true;       # Nintendo Switch 2 Pro Controller support
  #
  # These can be enabled in specific host configurations as needed.
}
