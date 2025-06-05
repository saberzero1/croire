{ pkgs, ... }:
{
  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    extraPackages = with pkgs; [
      jq
      lua
      nowplaying-cli
      sbarlua
      sketchybar
      sketchybar-app-font
      switchaudio-osx
    ];
  };
}
