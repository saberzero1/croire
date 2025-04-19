{ pkgs, ... }:
{
  home.file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
    "export MOZ_ENABLE_WAYLAND=1"
    "export NIXOS_OZONE_WL=1"
    "export XDG_SESSION_TYPE=wayland"
    "export XDG_CURRENT_DESKTOP=sway"
    "export XDG_SESSION_DESKTOP=sway"
  ];
}
