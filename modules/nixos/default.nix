# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake
, pkgs
, lib
, ...
}:
{
  imports = [
    flake.inputs.determinate.nixosModules.default
    ./packages
    ./services
    ./system
  ];

  # These users can add Nix caches.
  nix = {
    enable = true;
    # package = lib.mkDefault pkgs.nix;
    settings = {
      trusted-users = [
        "root"
        "saberzero1"
      ];
      inherit (flake.nixConfig)
        trusted-public-keys
        trusted-substituters
        ;
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
    };

    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run;
    };
  };
}
