{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    # https://opencode.ai/docs/config/
    settings = {
      "autoupdate" = "notify";
      "share" = "disabled";
      "theme" = "tokyonight";
      "tui" = {
        "scroll_speed" = 3;
        "scroll_acceleration" = {
          "enabled" = true;
        };
      };
      "plugin" = [
        "opencode-ignore"
        "@simonwjackson/opencode-direnv"
        "oh-my-opencode"
      ];
    };
    # opencode.ai/zen/v1/models for models
    agents = { };
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.opencode.commands
    commands = { };
    rules = "";
  };
}
