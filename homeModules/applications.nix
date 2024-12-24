{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs.vlc
        pkgs.steam
        pkgs.wofi
        pkgs.wofi-pass
      ];
    };
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
    };
  };
}
