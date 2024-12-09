{ flake, pkgs, ... }:
{
  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam;
    };
    zsh = {
      enable = true;
      enableLsColors = true;
    };
    dconf = {
      enable = true;
      profiles = {
        user = {
          databases = [];
        };
      };
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "wezterm";
    };
    sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        wf-recorder
        sway-contrib.grimshot
        mako # notification daemon
        grim
        slurp
        alacritty # Alacritty is the default terminal in the config
        dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
        wofi
        gtk-engine-murrine
        gtk_engines
        gsettings-desktop-schemas
        lxappearance
        dragon
        swappy
        xdg-utils
      ];
    };
    waybar = {
      enable = true;
    };
    uwsm = {
      enable = true;
      waylandCompositors = {
        sway = {
          prettyName = "Sway";
          comment = "Sway compositor managed by UWSM";
          binPath = "${pkgs.sway}/bin/sway";
        };
      };
    };
  };
}
