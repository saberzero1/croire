{ pkgs, ... }:
{
  services.skhd = {
    enable = false;
    package = pkgs.skhd;
    config = ''
      # Close current window
      # ctrl + shift - 0x0C : aerospace close
      # ctrl + alt + shift - 0x0C : aerospace close
      # alt + ctrl - 0x0C : aerospace close

      # Open launcher
      # ctrl + shift - 0x1F : /Applications/Sol.app/Contents/MacOS/sol
      # alt + ctrl - 0x1F : open -na /Applications/Sol.app/Contents/MacOS/sol
      # alt + ctrl - 0x1F : find -a "Sol"
      # alt + ctrl - 0x1F : find -a "Sol" -exec open {} \;

      # Close current window
      # cmd + alt - q: close
      cmd + alt - q: skhd -k "cmd - q "
      cmd + alt + ctrl - q: kill $(yabai -m query --windows --window | jq pid)

      # Open launcher
      cmd + alt - o: open -a /Applications/Sol.app/Contents/MacOS/sol

      # Open specific applications
      # Terminal
      cmd + alt - t: open -a Wezterm
      # Note-taking
      cmd + alt - n: open -a Obsidian
      # Browser
      cmd + alt - b: open -a Wavebox

      # Window focus
      cmd + alt - h: yabai -m window --focus west
      cmd + alt - j: yabai -m window --focus south
      cmd + alt - k: yabai -m window --focus north
      cmd + alt - l: yabai -m window --focus east

      # Window movement
      cmd + alt + ctrl - h: yabai -m window --swap west
      cmd + alt + ctrl - j: yabai -m window --swap south
      cmd + alt + ctrl - k: yabai -m window --swap north
      cmd + alt + ctrl - l: yabai -m window --swap east

      # Fullscreen
      cmd + alt - f: yabai -m window --toggle zoom-fullscreen

      # Restart yabai
      cmd + alt - r: yabai --service-stop; yabai --service-start

      # Move focus
      cmd + alt - 1: yabai -m space --focus 1
      cmd + alt - 2: yabai -m space --focus 2
      cmd + alt - 3: yabai -m space --focus 3
      cmd + alt - 4: yabai -m space --focus 4
      cmd + alt - 5: yabai -m space --focus 5
      cmd + alt - 6: yabai -m space --focus 6
      cmd + alt - 7: yabai -m space --focus 7
      cmd + alt - 8: yabai -m space --focus 8
      cmd + alt - 9: yabai -m space --focus 9
      cmd + alt - 0: yabai -m space --focus 10

      # Move windows
      cmd + alt + ctrl - 1: yabai -m window --space 1
      cmd + alt + ctrl - 2: yabai -m window --space 2
      cmd + alt + ctrl - 3: yabai -m window --space 3
      cmd + alt + ctrl - 4: yabai -m window --space 4
      cmd + alt + ctrl - 5: yabai -m window --space 5
      cmd + alt + ctrl - 6: yabai -m window --space 6
      cmd + alt + ctrl - 7: yabai -m window --space 7
      cmd + alt + ctrl - 8: yabai -m window --space 8
      cmd + alt + ctrl - 9: yabai -m window --space 9
      cmd + alt + ctrl - 0: yabai -m window --space 10
    '';
  };
}
