{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  espansoConfigFile = pkgs.writeText "default.yml" builtins.readFile /home/saberzero1/Documents/Repos/dotfiles/totten/config/default.yml;
  espansoMatchesFile = pkgs.writeText "base.yml" builtins.readFile /home/saberzero1/Documents/Repos/dotfiles/totten/config/base.yml;
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
            "L+ %h/.config/espanso/config/default.yml 0755 - - - ${espansoConfigFile}"
            "L+ %h/.config/espanso/match/base.yml 0755 - - - ${espansoMatchesFile}"
          ];
        };
      };
    };
  };
}
