{ flake, ... }:
{
  xdg.configFile = {
    "mimeapps.list".force = true;
    "paperwm/user.css" = {
      source = "${flake.inputs.dotfiles}/paperwm/user.css";
    };
    "paperwm/user.js" = {
      source = "${flake.inputs.dotfiles}/paperwm/user.js";
    };
    "sway-interactive-screenshot/config.toml" = {
      source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/config.toml";
    };
    "sway-interactive-screenshot/sway-interactive-screenshot" = {
      source = "${flake.inputs.dotfiles}/sway-interactive-screenshot/sway-interactive-screenshot";
    };
    ".assets/backgrounds" = {
      source = "${flake.inputs.dotfiles}/../assets/backgrounds";
      recursive = true;
    };
  };
}
