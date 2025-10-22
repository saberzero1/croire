{ pkgs, ... }:
{
  home.file = {
    sketchybarrc = {
      executable = true;
      target = ".config/sketchybar/sketchybarrc";
      text = ''
        #!/usr/bin/env bash

        # === CONFIG ROOT ===
        CONFIG_DIR="$HOME/.config/sketchybar"
        PLUGIN_DIR="$CONFIG_DIR/plugins"

        # === COLORS ===
        CLR_BG=0x00000000          # Transparent bar background
        CLR_COMP_BG=0xff1d2021     # Compartment background (Gruvbox dark)
        CLR_COMP_BORDER=0xff3c3836 # Compartment border (Gruvbox gray)
        CLR_FG=0xffebdbb2          # Foreground (Gruvbox light text)

        # === PADDING CONSTANTS
        BAR_PADDING=8             # Outer bar padding (use compartments for outer spacing)
        ITEM_PADDING=6             # Default horizontal padding between items
        ICON_PADDING=2             # Consistent icon inner padding (reduced from mixed 2/4 for tighter look)
        LABEL_PADDING=2            # Consistent label inner padding (unified from 4/2)
        COMP_PADDING=6             # Compartment outer padding (increased from bar-level 0 for breathing room)

        # === SYSTEM METRICS PROVIDER ===
        pkill -f stats_provider >/dev/null 2>&1
        /Users/nate/Documents/scripts/stats_provider --cpu temperature &

        # === BAR (No outer padding; defer to compartments) ===
        ${pkgs.sketchybar}/bin/sketchybar --bar position=top height=34 blur_radius=0 color="$CLR_BG" padding_left="$BAR_PADDING" padding_right="$BAR_PADDING"

        # === WORKSPACES ===
        ${pkgs.sketchybar}/bin/sketchybar --add event aerospace_workspace_change
        LABELS=("" "" "" "󱙺" "" "" "" "" "") # "󰎇" "󰖣"
        LEFT_SPACE_ITEMS=()
        INDEX=0

        for sid in $(aerospace list-workspaces --all); do
          label="''${LABELS[$INDEX]:-}"
          item="space.$sid"
          LEFT_SPACE_ITEMS+=("$item")

          ${pkgs.sketchybar}/bin/sketchybar --add item "$item" left \
            --subscribe "$item" aerospace_workspace_change \
            --set "$item" \
              background.color=0xff000000 \
              background.corner_radius=5 \
              background.height=20 \
              background.drawing=off \
              label="$label" \
              icon.padding_left="$ICON_PADDING" \
              icon.padding_right="$ICON_PADDING" \
              label.padding_left="$LABEL_PADDING" \
              label.padding_right="$LABEL_PADDING" \
              click_script="aerospace workspace $sid" \
              script="$PLUGIN_DIR/aerospace.sh $sid"

          ((INDEX++))
        done

        # === DEFAULTS (Unified paddings for all items/icons/labels) ===
        ${pkgs.sketchybar}/bin/sketchybar --default \
          padding_left="$ITEM_PADDING" \
          padding_right="$ITEM_PADDING" \
          icon.font="VictorMono Nerd Font:Regular:12.0" \
          label.font="VictorMono Nerd Font:Regular:14.0" \
          icon.color="$CLR_FG" \
          label.color="$CLR_FG" \
          icon.padding_left="$ICON_PADDING" \
          icon.padding_right="$ICON_PADDING" \
          label.padding_left="$LABEL_PADDING" \
          label.padding_right="$LABEL_PADDING"

        # === FRONT APP
        ${pkgs.sketchybar}/bin/sketchybar --add item front_app left \
          --set front_app \
            script="$PLUGIN_DIR/front_app.sh" \
            label.y_offset=1 \
            label.padding_right="$COMP_PADDING" \
          --subscribe front_app front_app_switched

        # === RIGHT SIDE ITEMS ===
        ${pkgs.sketchybar}/bin/sketchybar --add item clock right \
          --set clock update_freq=10 icon= script="$PLUGIN_DIR/clock.sh" label.padding_right="$COMP_PADDING" 

        ${pkgs.sketchybar}/bin/sketchybar --add item volume right \
          --set volume script="$PLUGIN_DIR/volume.sh" \
          --subscribe volume volume_change

        ${pkgs.sketchybar}/bin/sketchybar --add item battery right \
          --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
          --subscribe battery system_woke power_source_change

        ${pkgs.sketchybar}/bin/sketchybar --add item net right \
          --set net update_freq=120 icon= script="$PLUGIN_DIR/wifi.sh"

        ${pkgs.sketchybar}/bin/sketchybar --add item cpu_temp right \
          --set cpu_temp icon= script="${pkgs.sketchybar}/bin/sketchybar --set cpu_temp label=\$CPU_TEMP" icon.padding_left="$COMP_PADDING" \
          --subscribe cpu_temp system_stats

        # === ITEM GROUPS ===
        LEFT_ITEMS=("''${LEFT_SPACE_ITEMS[@]}" front_app)
        RIGHT_ITEMS=(colorlock volume battery net cpu_temp)

        # === COMPARTMENTS (Outer padding for clean edges; height=26 leaves vertical margin in 34pt bar) ===
        ${pkgs.sketchybar}/bin/sketchybar --add bracket left_compartment "''${LEFT_ITEMS[@]}" \
          --set left_compartment \
            background.color="$CLR_COMP_BG" \
            background.corner_radius=8 \
            background.height=26 \
            background.border_color="$CLR_COMP_BORDER" \
            background.border_width=1 \
            background.drawing=on

        ${pkgs.sketchybar}/bin/sketchybar --add bracket right_compartment "''${RIGHT_ITEMS[@]}" \
          --set right_compartment \
            background.color="$CLR_COMP_BG" \
            background.corner_radius=8 \
            background.height=26 \
            background.border_color="$CLR_COMP_BORDER" \
            background.border_width=1 \
            background.padding_left=0 \
            background.drawing=on

        # === FINALIZE ===
        ${pkgs.sketchybar}/bin/sketchybar --update
      '';
    };
    aerospace = {
      executable = true;
      target = ".config/sketchybar/plugins/aerospace.sh";
      text = ''
        #!/usr/bin/env bash

        if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
            ${pkgs.sketchybar}/bin/sketchybar --set $NAME label.color=0xffebdbb2
        else
            ${pkgs.sketchybar}/bin/sketchybar --set $NAME label.color=0x77ebdbb2
        fi
      '';
    };
    battery = {
      executable = true;
      target = ".config/sketchybar/plugins/battery.sh";
      text = ''
        #!/bin/sh

        PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
        CHARGING="$(pmset -g batt | grep 'AC Power')"

        if [ "$PERCENTAGE" = "" ]; then
          exit 0
        fi

        case "''${PERCENTAGE}" in
          9[0-9]|100) ICON=""
          ;;
          [6-8][0-9]) ICON=""
          ;;
          [3-5][0-9]) ICON=""
          ;;
          [1-2][0-9]) ICON=""
          ;;
          *) ICON=""
        esac

        if [[ "$CHARGING" != "" ]]; then
          ICON=""
        fi

        # The item invoking this script (name $NAME) will get its icon and label
        # updated with the current battery status
        ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" icon="$ICON" label="''${PERCENTAGE}%"
      '';
    };
    clock = {
      executable = true;
      target = ".config/sketchybar/plugins/clock.sh";
      text = ''
        #!/bin/sh

        # The $NAME variable is passed from sketchybar and holds the name of
        # the item invoking this script:
        # https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

        ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" label="$(date '+%A, %d %b, %I:%M %p')"

      '';
    };
    front_app = {
      executable = true;
      target = ".config/sketchybar/plugins/front_app.sh";
      text = ''
        #!/bin/sh

        # Some events send additional information specific to the event in the $INFO
        # variable. E.g. the front_app_switched event sends the name of the newly
        # focused application in the $INFO variable:
        # https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

        if [ "$SENDER" = "front_app_switched" ]; then
          ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" label="$INFO"
        fi
      '';
    };
    space = {
      executable = true;
      target = ".config/sketchybar/plugins/space.sh";
      text = ''
        #!/bin/sh

        # The $SELECTED variable is available for space components and indicates if
        # the space invoking this script (with name: $NAME) is currently selected:
        # https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

        ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" background.drawing="$SELECTED"
      '';
    };
    volume = {
      executable = true;
      target = ".config/sketchybar/plugins/volume.sh";
      text = ''
        #!/bin/sh

        # The volume_change event supplies a $INFO variable in which the current volume
        # percentage is passed to the script.

        if [ "$SENDER" = "volume_change" ]; then
          VOLUME="$INFO"

          case "$VOLUME" in
            [6-9][0-9]|100) ICON="󰕾"
            ;;
            [3-5][0-9]) ICON="󰖀"
            ;;
            [1-9]|[1-2][0-9]) ICON="󰕿"
            ;;
            *) ICON="󰖁"
          esac

          ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
        fi
      '';
    };
    wifi = {
      executable = true;
      target = ".config/sketchybar/plugins/wifi.sh";
      text = ''
        #!/bin/sh

        # Get the current Wi-Fi SSID
        wifi_name=$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2 p' | tr -d '\t')

        # If the Wi-Fi name is empty, set a default value (e.g., "No Wi-Fi")
        if [ -z "$wifi_name" ]; then
            wifi_name="Offline"
        fi

        # Set the Wi-Fi name as the label in SketchyBar
        ${pkgs.sketchybar}/bin/sketchybar --set "$NAME" label="$wifi_name"
      '';
    };
  };
}
