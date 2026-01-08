{ pkgs, ... }:
let
  opencodeModel = "github-copilot/gpt-5-mini";
in
{
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    # https://opencode.ai/docs/config/
    settings = {
      "autoupdate" = "notify";
      "share" = "disabled";
      "theme" = "tokyonight";
      "model" = opencodeModel;
      "tui" = {
        "scroll_speed" = 3;
        "scroll_acceleration" = {
          "enabled" = true;
        };
      };
    };
    agents = { };
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.opencode.commands
    commands = { };
    rules = '''';
    # Plugins configuration
    plugins = [
      "opencode-ignore"
      "@simonwjackson/opencode-direnv"
      "code-yeongyu/oh-my-opencode"
    ];
  };
}
