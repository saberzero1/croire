{ ... }:
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = { };
    extraConfig = ''
      #!/usr/bin/env bash

      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # Unload the macOS WindowManager process
      # launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist >/dev/null 2>&1 &

      function setup_space {
        local idx="$1"
        local label="$2"
        local space=
        echo "setup space $idx : $label"

        space=$(yabai -m query --spaces --space $idx)

        if [ -z "$space" ]; then
          yabai -m space --create
        fi

        yabai -m space "$idx" --label "$label"
      }

      #########
      # Setup #
      #########
      setup_space 1 one
      setup_space 2 two
      setup_space 3 three
      setup_space 4 four
      setup_space 5 five
      setup_space 6 six
      setup_space 7 seven
      setup_space 8 eight
      setup_space 9 nine
      setup_space 10 ten

      # Assign applications to spaces
      yabai -m rule --add app="^Wezterm$" space=^1
      yabai -m rule --add app="^Ghostty$" space=^1
      yabai -m rule --add app="^Obsidian$" space=2
      yabai -m rule --add app="^Wavebox$" space=3

      # window opacity (default: off)
      # render all unfocused windows with 90% opacity
      yabai -m config window_opacity on
      yabai -m config active_window_opacity 1.0
      yabai -m config normal_window_opacity 0.9

      # yabai -m signal --add event=window_focused app=".*CleanShot X.*" action="yabai -m config active_window_opacity 1.0"
      # yabai -m signal --add event=window_focused app=".*CleanShot X.*" action="yabai -m config normal_window_opacity 1.0"

      # Nice trick shared by @timhansinger8030 in my YouTube video https://youtu.be/SLCR1oO65GI
      # Allows to see mission control apps when calling mission control from a transparent app
      # yabai -m signal --add event=mission_control_enter action="yabai -m config normal_window_opacity 1.0"
      # yabai -m signal --add event=mission_control_exit action="yabai -m config active_window_opacity 1.0"

      # https://github.com/koekeishiya/yabai/issues/1929

      # Set all apps to the "normal" sub-layer, otherwise they all start on the "below"
      # sub-layer. Doing this fixed the issue I had with floating windows with OBS,
      # davinci resolve and other apps where their floating windows would show on top
      # of other apps

      yabai -m rule --add app=".*" sub-layer=normal

      # "mouse_follows_focus on" will move the mouse back to the center, but DISABLE it or it will
      # be a nightmare to use iStat Menus
      yabai -m config mouse_follows_focus off

      # Configure the layout mode
      # "stack" - is what I use, keeps a single app on the front
      # "bsp" - binary space partitioning enables automatic tiling (partitioning)
      # "float" - default mode, windows are not managed
      # yabai -m config layout stack
      yabai -m config layout bsp
      # yabai -m config layout float

      ##########
      # Layout #
      ##########

      # Make space for sketchybar
      yabai -m config external_bar all:40:0

      # no spacing around windows
      yabai -m config top_padding 0
      yabai -m config bottom_padding 0
      yabai -m config left_padding 0
      yabai -m config right_padding 0
      yabai -m config window_gap 0

      # on or off (default: off)
      # autobalance window sizing
      yabai -m config auto_balance on

      # place new windows to the right if vertical split, or below if horizontal split
      yabai -m config window_placement second_child

      # modify window shadows (default: on, options: on, off, float)
      # show shadows only for floating windows
      yabai -m config window_shadow float

      # Move to any other visible windown whenever a window is closed
      yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"

      # Exclusion rules
      # This makes sure that the windows are not managed by yabai
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^Stats$" manage=off
      yabai -m rule --add app="^Disk Utility$" manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off

      ###############
      # keybindings #
      ###############

      ############
      # Defaults #
      ############

      # yabai -m config \
      #   focus_follows_mouse off \
      #   window_origin_display default \
      #   window_placement second_child \
      #   window_zoom_persist on \
      #   window_shadow off \
      #   window_animation_duration 2 \
      #   window_animation_frame_rate 120 \
      #   window_opacity_duration 0.0 \
      #   insert_feedback_color 0xffd75f5f \
      #   active_window_border_color 0xff775759 \
      #   normal_window_border_color 0xff555555 \
      #   window_border_width 4 \
      #   window_border_radius 12 \
      #   window_border_blur off \
      #   window_border_hidpi on \
      #   window_border off \
      #   split_ratio 0.50 \
      #   split_type auto \
      #   auto_balance off \
      #   window_gap 06 \
      #   mouse_modifier fn \
      #   mouse_action1 move \
      #   mouse_action2 resize \
      #   mouse_drop_action swap

      # THIS IS VERY IMPORTANT
      # It ensures that when I restart yabai, all the rules (including the manage=off rules)
      # are reapplied to existing windows
      # Otherwise yabai takes care of management and I couldnt resize apps like
      # packet tracer for example
      yabai -m rule --apply
    '';
  };
}
