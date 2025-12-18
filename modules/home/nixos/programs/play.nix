{ flake
, lib
, pkgs
, config
, ...
}:
let
  inherit (flake) inputs;
in
{
  # Import the play.nix Home Manager module
  imports = [
    inputs.play-nix.homeManagerModules.play
  ];

  # Configure monitors for automatic gamescope settings
  monitors = [
    {
      name = "eDP-1"; # Adjust based on your monitor
      primary = true;
      width = 2560;
      height = 1440;
      refreshRate = 165;
      hdr = false;
      vrr = false;
    }
  ];

  # Gaming configuration using play.nix
  play = {
    # Enable gamescope wrapper with intelligent defaults
    gamescoperun = {
      enable = true;
      defaultHDR = false; # Disable HDR by default for NVIDIA
      defaultWSI = true; # Wayland Surface Interface
      defaultSystemd = false; # Don't use systemd-run by default
      baseOptions = {
        "output-width" = 2560;
        "output-height" = 1440;
      };
      environment = {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
      };
    };

    # Create Steam wrapper that runs through gamescope
    wrappers = {
      steam-gamescope = {
        enable = true;
        command = "${lib.getExe pkgs.steam} -bigpicture -tenfoot";
        useHDR = false;
        useSystemd = true; # Use systemd-run for Steam
        extraOptions = {
          "steam" = true; # Enable Steam-specific optimizations
          "fsr-upscaling" = true; # Enable FSR upscaling
        };
        environment = {
          STEAM_FORCE_DESKTOPUI_SCALING = 1;
          STEAM_GAMEPADUI = 1;
          __NV_PRIME_RENDER_OFFLOAD = 1;
          __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
      };
    };
  };

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
