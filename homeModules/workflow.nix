{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  espansoConfigFile = pkgs.writeText "default.yml" ''
    includes:
      - "../../Documents/Repos/dotfiles/totten/config/default.yml"
  '';
  espansoMatchesFile = pkgs.writeText "base.yml" ''
    includes:
      - "../../Documents/Repos/dotfiles/totten/config/base.yml"
  '';
in
{
  config = {
    home = {
      packages = [
        pkgs.ulauncher
      ];
    };
    services = {
      espanso = {
        enable = true;
        package = pkgs.espanso;
        configs = { };
        matches = { };
      };
    };
    systemd = {
      user = {
        tmpfiles = {
          rules = [
            "L+ %h/.config/espanso/default.yml 0755 - - - ${espansoConfigFile}"
            "L+ %h/.config/espanso/base.yml 0755 - - - ${espansoMatchesFile}"
          ];
        };
      };
    };
  };
}
