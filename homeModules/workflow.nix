{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  username = inputs.self.username;
  espansoConfigFileContent = builtins.readFile "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/totten/config/default.yml";
  espansoMatchesFileContent = builtins.readFile "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/totten/match/base.yml";
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
        enable = false;
        package = pkgs.pkgs.espanso-wayland;
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
