{ flake
, pkgs
, inputs
, config
, ...
}:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    wofi = {
      package = pkgs.wofi;
      enable = true;
      settings = {
        stylesheet = "style.css";
        show = "drun";
        matching = "contains";
        no_actions = true;
        width = "550";
        height = "350";
        always_parse_args = true;
        show_all = true;
        print_command = true;
        layer = "overlay";
        insensitive = true;
        allow_markup = true;
        allow_images = true;
      };
      style = ''
        window {
          margin: 0px;
          border: 2px solid #414868;
          border-radius: 5px;
          background-color: #24283b;
          font-family: monospace;
          font-size: 12px;
        }

        #input {
          margin: 5px;
          border: 1px solid #24283b;
          color: #c0caf5;
          background-color: #24283b;
        }

        #input image {
          color: #c0caf5;
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: #24283b;
        }

        #outer-box {
          margin: 5px;
          border: none;
          background-color: #24283b;
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #c0caf5;
        }

        #entry:selected {
          background-color: #414868;
          font-weight: normal;
        }

        #text:selected {
          background-color: #414868;
          font-weight: normal;
        }
      '';
    };

    chromium = {
      enable = true;
      package = pkgs.wavebox;
    };

    pay-respects = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      package = pkgs.pay-respects;
    };

    fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
    };

    waybar = {
      enable = true;
      settings = [
        {
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
            exec = "${flake.inputs.dotfiles}/waybar/waybar-date.sh";
          };

          "custom/power" = {
            format = "󰐥";
            on-clock = "${flake.inputs.dotfiles}/waybar/waybar-power.sh";
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

    git = {
      signing = {
        key = null;
        signByDefault = true;
      };
      diff-so-fancy = {
        changeHunkIndicators = true;
        enable = true;
        markEmptyLines = true;
        pagerOpts = [
          "--tabs=4"
          "-RFX"
        ];
        rulerWidth = null;
        stripLeadingSymbols = true;
        useUnicodeRuler = true;
      };
      enable = true;
      package = pkgs.git;
      ignores = [
        "*.swp"
      ];
      lfs = {
        enable = true;
      };
      /*
        signing = {
        # key = null;
        signByDefault = true;
        gpgPath = "${pkgs.gnupg}/bin/gpg2";
        };
      */
      userEmail = "github@emilebangma.com";
      userName = "saberzero1";
      extraConfig = {
        init.defaultBranch = "master";
        core = {
          editor = "nvim";
          autocrlf = "input";
        };
        commit.gpgsign = true;
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };

    ghostty = {
      enable = true;
    };

    gh = {
      enable = true;
      package = pkgs.gh;
      gitCredentialHelper = {
        enable = true;
        hosts = [
          "https://github.com"
          "https://gist.github.com"
        ];
      };
      extensions = [
        pkgs.gh-dash
      ];
    };

    lazygit = {
      enable = true;
      package = pkgs.lazygit;
      settings = {
        gui = {
          nerdFontsVersion = "3";
          theme = {
            activeBorderColor = [
              "#ff9e64"
              "bold"
            ];
            inactiveBorderColor = [
              "#29a4bd"
            ];
            searchingActiveBorderColor = [
              "#ff9e64"
              "bold"
            ];
            optionsTextColor = [
              "#7aa2f7"
            ];
            selectedLineBgColor = [
              "#2e3c64"
            ];
            cherryPickedCommitFgColor = [
              "#7aa2f7"
            ];
            cherryPickedCommitBgColor = [
              "#bb92f7"
            ];
            markedBaseCommitFgColor = [
              "#7aa2f7"
            ];
            markedBaseCommitBgColor = [
              "#e0af68"
            ];
            unstagedChangesColor = [
              "#db4b4b"
            ];
            defaultFgColor = [
              "#c0caf5"
            ];
          };
        };
      };
    };

    swaylock = {
      enable = true;
      settings = {
        ignore-empty-password = true;
        disable-caps-lock-text = true;
        image = "${flake.inputs.dotfiles}/assets/wallpaper_night.png";
        effect-blur = "3x5";
        font = "Monaspace Neon";

        text-ver-color = "00000000";
        text-wrong-color = "00000000";
        text-clear-color = "00000000";
        inside-color = "00000000";
        inside-ver-color = "00000000";
        inside-wrong-color = "00000000";
        inside-clear-color = "00000000";
        inside-caps-lock-color = "00000000";
        ring-color = "00000000";
        ring-ver-color = "00000000";
        ring-wrong-color = "00000000";
        ring-clear-color = "00000000";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-ver-color = "00000000";
        key-hl-color = "00000000";
        bs-hl-color = "00000000";
        caps-lock-bs-hl-color = "00000000";
        caps-lock-key-hl-color = "00000000";
        separator-color = "00000000";

        scaling = "fill";
        indicator = true;
        clock = true;
        timestr = "%I:%M %p";
        datestr = "%A, %d %B";
        indicator-x-position = 250;
        indicator-y-position = 975;
        indicator-radius = 200;
        font-size = 100;
        text-color = "c0caf5";
      };
    };
  };
}
