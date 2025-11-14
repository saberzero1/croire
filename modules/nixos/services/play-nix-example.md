# Example configuration for using play.nix
# This file documents how to enable and configure play.nix features
# in your NixOS and Home Manager configurations.

## NixOS Configuration (modules/nixos/services/play.nix)
#
# The play.nix module is automatically imported and provides these options:
#
# {
#   play = {
#     # AMD GPU optimization via LACT daemon
#     amd.enable = true;
#     
#     # Steam with Proton-CachyOS and gaming optimizations
#     steam = {
#       enable = true;
#       extraCompatPackages = [ ]; # Additional Proton packages
#       extraPkgs = pkgs: with pkgs; [ /* extra packages */ ];
#     };
#     
#     # Lutris game manager
#     lutris.enable = true;
#     
#     # Performance optimization during gaming
#     gamemode = {
#       enable = true;
#       settings = {
#         general = {
#           softrealtime = "auto";
#           inhibit_screensaver = 1;
#           renice = 15;
#         };
#       };
#     };
#     
#     # Process scheduling optimization
#     ananicy.enable = true;
#     
#     # Nintendo Switch 2 Pro Controller support (USB only)
#     procon2.enable = true;
#   };
# }

## Home Manager Configuration (modules/home/nixos/programs/play.nix)
#
# The play.nix Home Manager module is automatically imported and provides:
#
# {
#   play = {
#     # Configure monitors for automatic gamescope settings
#     monitors = [
#       {
#         name = "DP-1";
#         primary = true;
#         width = 2560;
#         height = 1440;
#         refreshRate = 144;
#         hdr = true;
#         vrr = true;  # Variable Refresh Rate / FreeSync
#       }
#     ];
#     
#     # Enable gamescope wrapper with intelligent defaults
#     gamescoperun = {
#       enable = true;
#       
#       # Global defaults (can be overridden per-wrapper)
#       defaultHDR = null;      # null = auto-detect from monitor
#       defaultWSI = true;      # Wayland Surface Interface
#       defaultSystemd = false; # Use systemd-run
#       
#       # Override base gamescope options
#       baseOptions = {
#         "fsr-upscaling" = true;
#       };
#       
#       # Environment variables
#       environment = {
#         # Custom variables here
#       };
#     };
#     
#     # Create application wrappers that run through gamescope
#     wrappers = {
#       steam-gamescope = {
#         enable = true;
#         command = "\${lib.getExe osConfig.programs.steam.package} -bigpicture -tenfoot";
#         useHDR = true;        # Per-wrapper HDR override
#         useWSI = null;        # Use global setting
#         useSystemd = true;    # Per-wrapper systemd override
#         extraOptions."steam" = true;
#         environment = {
#           STEAM_FORCE_DESKTOPUI_SCALING = 1;
#           STEAM_GAMEPADUI = 1;
#         };
#       };
#       
#       heroic-gamescope = {
#         enable = true;
#         package = pkgs.heroic;
#         extraOptions."fsr-upscaling" = true;
#       };
#     };
#   };
# }

## Available Packages (via overlay)
#
# These packages are available through the overlay:
# - pkgs.proton-cachyos: CachyOS optimized Proton version
# - pkgs.procon2-init: Nintendo Switch 2 Pro Controller USB initialization

## Usage
#
# After configuring wrappers, use them from the command line:
#
#   gamescoperun heroic
#   gamescoperun -x "--fsr-upscaling-sharpness 5" heroic
#
# Or run the wrapper directly:
#
#   steam-gamescope
#   heroic-gamescope

## Requirements
#
# - NixOS with Home Manager (as a NixOS module)
# - Wayland desktop environment
# - Fish shell (used internally by wrappers)
# - At least one monitor configured with primary = true (for Home Manager)
