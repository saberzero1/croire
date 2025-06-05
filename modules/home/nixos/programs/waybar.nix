{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        position = "top";
        height = 38;
        modules-left = [ "sway/workspaces" ];
        modules-right = [
          "sway/mode"
          "network"
          "pulseaudio"
          "battery"
          "custom/date"
          "memory"
          "cpu"
          "clock"
          "tray"
          "custom/power"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          persistent_workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
          format-icons = {
            "1" = "󰋜"; # Home
            "2" = "󰖟"; # Web
            "3" = "󰠮"; # Notes/Writing
            "4" = "󰭹"; # Chat
            "5" = "󱓷"; # Books/Reading
            "6" = "󱇧"; # Development/Coding
            "7" = "󰊢"; # Git/Version Control
            "8" = "󰖲"; # Misc/Panes
            "9" = "󰕧"; # Video/Camera
            "10" = "󰝚"; # Music
          };
        };
        "custom/date" = {
          format = "󰸗 {}";
          interval = 3600;
          exec = "${self}/programs/waybar/waybar-date.sh";
        };
        "custom/power" = {
          format = "󰐥";
          on-clock = "${self}/programs/waybar/waybar-power.sh";
        };
        "clock" = {
          format = "󰅐 {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄{capacity}%";
          format-alt = "{time} {icon}";
          format-full = "󱈑 {capacity}%";
          format-icons = [
            "󱊡"
            "󱊢"
            "󱊣"
          ];
        };
        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} 󰈁";
          format-linked = "{ifname} (No IP) 󱚵";
          format-disconnected = "󰤮 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁 Muted";
          format-icons = {
            headphone = "";
            hands-free = "󰏳";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "tray" = {
          spacing = 10;
        };
        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };
        "memory" = {
          format = "{}% ";
        };
      }
    ];
    style = ''
      * {
      border: none;
      border-radius: 0;
      font-family: mononoki Nerd Font;
      font-size: 14px;
      min-height: 0;
      }
      window#waybar {
      background: transparent;
      color: white;
      }
      #workspaces {
      background-color: #24283b;
      margin: 5px;
      margin-left: 10px;
      border-radius: 5px;
      }
      #workspaces button {
      padding: 5px 10px;
      color: #c0caf5;
      }
      #workspaces button.focused {
      color: #24283b;
      background-color: #7aa2f7;
      border-radius: 5px;
      }
      #workspaces button:hover {
      background-color: #7dcfff;
      color: #24283b;
      border-radius: 5px;
      }
      #sway-mode, #custom-date, #clock, #battery, #pulseaudio, #network, #cpu, #memory {
      background-color: #24283b;
      padding: 5px 10px;
      margin: 5px 0px;
      }
      #custom-date {
      color: #7dcfff;
      }
      #custom-power {
      color: #24283b;
      background-color: #db4b4b;
      border-radius: 5px;
      margin-right: 10px;
      margin-top: 5px;
      margin-bottom: 5px;
      margin-left: 0px;
      padding: 5px 10px;
      }
      #clock {
      color: #bb9af7;
      border-radius: 0px 5px 5px 0px;
      margin-right: 10px;
      }
      #battery {
      color: #9ece6a;
      }
      #battery.charging {
      color: #9ece6a;
      }
      #battery.warning:not(.charging) {
      background-color: #f7768e;
      color: #24283b;
      border-radius: 5px 5px 5px 5px;
      }
      #network {
      color: #f7768e;
      border-radius: 5px 0px 0px 5px;
      }
      #pulseaudio {
      color: #e0af68;
      }
      #memory {
      color: #2ac3de;
      }
      #cpu {
      color: #7aa2f7;
      }
      #sway-mode {
      color: #c0caf5;
      }
      #tray {
      background-color: #24283b;
      border-radius: 5px;
      margin-right: 10px;
      margin-top: 5px;
      margin-bottom: 5px;
      margin-left: 0px;
      padding: 5px 10px;
      }
    '';
  };
}
