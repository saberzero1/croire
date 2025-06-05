{ pkgs, ... }:
{
  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    extraPackages = with pkgs; [
      jq
      sketchybar
    ];
  };
}
