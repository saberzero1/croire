{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  espansoConfigFileContent = builtins.readFile /home/saberzero1/Documents/Repos/dotfiles/totten/config/default.yml;
  espansoMatchesFileContent = builtins.readFile /home/saberzero1/Documents/Repos/dotfiles/totten/match/base.yml;
  espansoConfigFile = pkgs.writeText "default.yml" "${espansoConfigFileContent}";
  espansoMatchesFile = pkgs.writeText "base.yml" "${espansoMatchesFileContent}";
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
        wayland = true;
        package = pkgs.espanso-wayland;
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
