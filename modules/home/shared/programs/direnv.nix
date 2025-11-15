{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  enableInstant = false;
in
{
  imports = [
    inputs.direnv-instant.homeModules.direnv-instant
  ];

  programs = {
    direnv = {
      enable = true;
      # These should be set to false when using direnv-instant
      enableBashIntegration = !enableInstant;
      enableZshIntegration = !enableInstant;
      # enableFishIntegration = !enableInstant;
      # enableNushellIntegration = !enableInstant;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
    direnv-instant = {
      enable = enableInstant;
    };
  };
}
