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
    };
  };
}
