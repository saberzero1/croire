# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # These users can add Nix caches.
  nix.settings.trusted-users = [
    "root"
    "saberzero1"
  ];

  system = {
    activationScripts = {
      postActivation.text = ''
        echo "Setting tmux-sessionizer permissions"
        sudo chmod +x "$(readlink "$HOME/.config/tmux/scripts/tmux-sessionizer")"
      '';
    };
  };

  services.openssh.enable = true;

  programs = {
    zsh.enable = true;

    # GeForce Now for Linux fix
    # https://github.com/hmlendea/gfn-electron/issues/250#issuecomment-2408948652
    gamescope = {
      enable = true;
      package = pkgs.gamescope;
      /*
        args = [
        "-b"
        "-W 1920"
        "-H 1080"
        "-r 60"
        "--backend sdl"
        "--expose-wayland"
        "--prefer-vk-device"
        "--force-grab-cursor"
        ];
      */
    };
  };
}
