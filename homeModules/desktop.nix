{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  browser = [
    "wavebox.desktop"
  ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
  };
in
{
  config = {
    dconf = {
      settings = with lib.hm.gvariant; {
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///home/saberzero1/Documents/Repos/dotfiles/croire/assets/wallpaper.png";
          picture-uri-dark = "file:///home/saberzero1/Documents/Repos/dotfiles/croire/assets/wallpaper.png";
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "ranger.desktop"
            "wavebox.desktop"
            "obsidian.desktop"
            "discord.desktop"
            "nvim.desktop"
          ];
        };
      };
    };
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = associations;
        associations.added = associations;
      };
      configFile = {
        "mimeapps.list".force = true;
        "paperwm/user.css" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/paperwm/user.css"; };
        "paperwm/user.js" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/paperwm/user.js"; };
        "sway/config" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/croire/configFiles/sway/config"; };
      };
    };
    programs = {
      waybar = {
        enable = true;
        settings = [{
          position = "top";
          height = 30;
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
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
              "6" = [];
              "7" = [];
              "8" = [];
              "9" = [];
              "10" = [];
            };
            format-icons = {
              "1" = "󰋜";
              "2" = "󰖟";
              "3" = "󰠮";
              "4" = "󰭹";
              "5" = "󱓷";
              "6" = "󱇧";
              "7" = "󰊢";
              "8" = "󰖲";
              "9" = "󰕧";
              "10" = "󰝚";
            };
          };
          "custom/date" = {
            format = "󰸗 {}";
            interval = 3600;
            exec = "$HOME/Documents/Repos/dotfiles-submodules/croire/configFiles/waybar/waybar-date.sh";
          };
          "custom/power" = {
            format = "󰐥";
            on-clock = "$HOME/Documents/Repos/dotfiles-submodules/croire/configFiles/waybar/waybar-power.sh";
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
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "󰤮 Disconnected";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          "pulseaudio" = {
            format = "{icon}  {volume}%";
            format-muted = "󰖁 Muted";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
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
        }];
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
color #24283b;
border-radius: 5px;
margin-right: 10px;
margin-top: 5px;
margin-bottom: 5px;
margin-left: 0px;
padding: 5px 10px;
}
        '';
      };
    };
  };
}
