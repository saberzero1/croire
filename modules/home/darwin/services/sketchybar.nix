{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  home.file = {
    sketchybarrc = {
      executable = true;
      target = ".config/sketchybar/sketchybarrc";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/sketchybarrc";
    };
    aerospace = {
      executable = true;
      target = ".config/sketchybar/plugins/aerospace.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/aerospace.sh";
    };
    battery = {
      executable = true;
      target = ".config/sketchybar/plugins/battery.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/battery.sh";
    };
    clock = {
      executable = true;
      target = ".config/sketchybar/plugins/clock.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/clock.sh";
    };
    front_app = {
      executable = true;
      target = ".config/sketchybar/plugins/front_app.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/front_app.sh";
    };
    space = {
      executable = true;
      target = ".config/sketchybar/plugins/space.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/space.sh";
    };
    volume = {
      executable = true;
      target = ".config/sketchybar/plugins/volume.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/volume.sh";
    };
    wifi = {
      executable = true;
      target = ".config/sketchybar/plugins/wifi.sh";
      text = pkgs.lib.readFile "${self}/programs/sketchybar/plugins/wifi.sh";
    };
    finder-move = {
      executable = true;
      target = ".config/aerospace/finder-move.sh";
      text = pkgs.lib.readFile "${self}/programs/aerospace/finder-move.sh";
    };
  };
}
