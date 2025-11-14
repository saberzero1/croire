{ flake
, lib
, pkgs
, config
, osConfig
, ...
}:
{
  imports = [
    flake.inputs.self.homeModules.default
    flake.inputs.self.homeModules.linux-only
  ];
  
  home = {
    username = "saberzero1";
    stateVersion = "24.11";
  };

  # Gaming configuration using play.nix
  play = {
    # Configure monitors for automatic gamescope settings
    monitors = [
      {
        name = "HDMI-1";  # Adjust based on your monitor
        primary = true;
        width = 1920;
        height = 1080;
        refreshRate = 60;
        hdr = false;
        vrr = false;
      }
    ];

    # Enable gamescope wrapper with intelligent defaults
    gamescoperun = {
      enable = true;
      defaultHDR = false;      # Disable HDR by default for NVIDIA
      defaultWSI = true;       # Wayland Surface Interface
      defaultSystemd = false;  # Don't use systemd-run by default
    };

    # Create Steam wrapper that runs through gamescope
    wrappers = {
      steam-gamescope = {
        enable = true;
        command = "${lib.getExe osConfig.programs.steam.package} -bigpicture -tenfoot";
        useHDR = false;
        useSystemd = true;  # Use systemd-run for Steam
        extraOptions = {
          "steam" = true;  # Enable Steam-specific optimizations
          "fsr-upscaling" = true;  # Enable FSR upscaling
        };
        environment = {
          STEAM_FORCE_DESKTOPUI_SCALING = 1;
          STEAM_GAMEPADUI = 1;
        };
      };
    };
  };
}
