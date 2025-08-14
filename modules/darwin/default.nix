# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{ ... }:
{
  imports = [
    ./dock
    ./packages
    ./services
    ./system
  ];

  # These users can add Nix caches.
  nix = {
    enable = false;
    settings.trusted-users = [
      "root"
      "emile"
    ];
    channel = {
      enable = true;
    };
  };

  local = {
    dock.enable = true;
    dock.entries = [
      { path = "/Applications/Wavebox.app"; }
      { path = "/Applications/Ghostty.app"; }
      # { path = "/etc/profiles/per-user/emile/bin/ghostty"; }
      { path = "/Applications/Obsidian.app"; }
      # { path = "${pkgs.wezterm}/Applications/Wezterm.app"; }
    ];
  };
}
