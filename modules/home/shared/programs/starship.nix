{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML "${self}/programs/starship/starship.toml";
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
