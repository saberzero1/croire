{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      let
      nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim";
        # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
        # ref = "nixos-23.05";
      });
      in
      packages = [
        # For home-manager
        nixvim.homeManagerModules.nixvim
        # For NixOS
        # nixvim.nixosModules.nixvim
        # For nix-darwin
        # nixvim.nixDarwinModules.nixvim
      ];
    };
    programs = {
      nixvim = {
        enable = true;
      };
    };
  };
}
