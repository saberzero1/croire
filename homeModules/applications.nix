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
@define-color bg #282a36;
@define-color purple #bd93f9;
@define-color orange #ffb86c;
@define-color green #50fa7b;
@define-color pink #ff79c6;
@define-color fg #f8f8f2;
@define-color bg-light #44475a;
@define-color cyan #8be9fd;
@define-color yellow #f1fa8c;

#window {
  margin: 0px;

  border-radius: 7px;
  background-color: @bg;
  font-family: "Mononoki Nerd Font Mono";
  font-size: 16px;
  background: @bg;
  border: 3px solid @purple;
}

#input {
  margin: 15px;
  border: 2px solid @orange;
  border-radius: 10px;
  color: @fg;
  background: @bg;
}

#input:focus {
  background: @bg-light;
}

#input:focus image {
  color: @purple;
}

#input image {
  color: @purple;
}

#inner-box {
  margin: 5px;
  border: none;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 7px;
  background-color: inherit;
}

#outer-box {
  margin: 5px;
  border: none;
  background-color: inherit;
  border-radius: 7px;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 5px;
  border: none;
  color: @fg;
}

#entry:selected {
  border-radius: 10px;
  background: @purple;
  background: linear-gradient(90deg, @purple, @pink);
}

#text:selected {
	background-color: inherit;
	color: @bg;
	font-weight: normal;
}
'';
      };
    };
  };
}
