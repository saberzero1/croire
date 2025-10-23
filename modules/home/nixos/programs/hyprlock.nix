{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
      };
      background = [
        {
          path = "${self}/assets/backgrounds/wallpaper_night.png";
          blur_passes = 3;
          blur_size = 5;
        }
      ];
      input-field = [
        {
          size = "400, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(c0caf5)";
          inner_color = "rgb(24283b)";
          outer_color = "rgb(7aa2f7)";
          outline_thickness = 2;
          placeholder_text = "<i>Password...</i>";
          shadow_passes = 2;
        }
      ];
      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(c0caf5)";
          font_size = 100;
          font_family = "Monaspace Neon";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
          color = "rgb(c0caf5)";
          font_size = 25;
          font_family = "Monaspace Neon";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
