{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  xdg.configFile = {
    "mimeapps.list".force = true;
    "paperwm/user.css" = {
      source = "${self}/programs/paperwm/user.css";
    };
    "paperwm/user.js" = {
      source = "${self}/programs/paperwm/user.js";
    };
    "sway-interactive-screenshot/config.toml" = {
      source = "${self}/programs/sway-interactive-screenshot/config.toml";
    };
    "sway-interactive-screenshot/sway-interactive-screenshot" = {
      source = "${self}/programs/sway-interactive-screenshot/sway-interactive-screenshot";
    };
    ".assets/backgrounds" = {
      source = "${self}/assets/backgrounds";
      recursive = true;
    };
  };
}
