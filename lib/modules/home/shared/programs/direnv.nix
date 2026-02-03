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
      package = pkgs.direnv;
      # These should be set to false when using direnv-instant
      enableBashIntegration = !enableInstant;
      enableZshIntegration = !enableInstant;
      enableFishIntegration = false;
      enableNushellIntegration = !enableInstant;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
      stdlib = "";
    };
    direnv-instant = {
      enable = enableInstant;
    };
  };
}
