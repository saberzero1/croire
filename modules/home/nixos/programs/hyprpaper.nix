{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${self}/assets/backgrounds/wallpaper_night.png"
      ];
      wallpaper = [
        ",${self}/assets/backgrounds/wallpaper_night.png"
      ];
      splash = false;
      ipc = "on";
    };
  };
}
