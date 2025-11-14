{ flake, lib, config, ... }:
let
  inherit (flake) inputs;
in
{
  # Import the play.nix Home Manager module
  imports = [
    inputs.play-nix.homeManagerModules.play
  ];

  # play.nix home manager module provides the following options:
  # 
  # play.monitors - Configure monitors for automatic gamescope settings
  # play.gamescoperun - Enable gamescope wrapper with intelligent defaults
  # play.wrappers - Create application wrappers that run through gamescope
  #
  # Example configuration:
  # play = {
  #   monitors = [{
  #     name = "DP-1";
  #     primary = true;
  #     width = 2560;
  #     height = 1440;
  #     refreshRate = 144;
  #     hdr = true;
  #     vrr = true;
  #   }];
  #   
  #   gamescoperun = {
  #     enable = true;
  #     defaultHDR = null;      # null = auto-detect monitor HDR
  #     defaultWSI = true;      # Wayland Surface Interface
  #     defaultSystemd = false; # systemd-run setting
  #   };
  #   
  #   wrappers = {
  #     steam-gamescope = {
  #       enable = true;
  #       command = "\${lib.getExe osConfig.programs.steam.package} -bigpicture -tenfoot";
  #       useHDR = true;
  #       extraOptions."steam" = true;
  #     };
  #   };
  # };
  #
  # These can be configured in specific user configurations as needed.
}
