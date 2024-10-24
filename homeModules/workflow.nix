{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }:
let
  username = inputs.self.username;
  # espansoConfigFileContent = builtins.readFile "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/totten/config/default.yml";
  # espansoMatchesFileContent = builtins.readFile "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/totten/match/base.yml";
  # espansoConfigFile = pkgs.writeText "default.yml" ''
  #   extra_includes:
  #     - "${espansoConfigFileContent}/Documents/Repos/dotfiles-submodules/totten/config/default.yml"
  # '';
  # espansoMatchesFile = pkgs.writeText "base.yml" ''
  #   extra_includes:
  #     - "${espansoConfigFileContent}/Documents/Repos/dotfiles-submodules/totten/match/base.yml"
  # '';
in
{
  config = {
    home = {
      packages = [
        pkgs.ulauncher
        #pkgs.espanso
        pkgs.espanso-wayland
        pkgs.wl-clipboard
        #config.programs.espanso.package
      ];
    };
    services = {
      espanso = {
        enable = true;
        package = pkgs.espanso-wayland;
        configs = { };
        matches = { };
      };
    };
    # systemd = {
    #   user = {
    #     tmpfiles = {
    #       rules = [
    #         "L+ %h/.config/espanso/config/default.yml 0755 - - - ${espansoConfigFile}"
    #         "L+ %h/.config/espanso/match/base.yml 0755 - - - ${espansoMatchesFile}"
    #       ];
    #     };
    #   };
    # };
    # systemd = {
    #   services = {
    #     espanso = {
    #       enable = true;
    #       #package = config.home.packages.espanso.package;
    #       serviceConfig = {
    #         execStart = "${profileDirectory}/bin/espanso start";
    #         Restart = "always";
    #         RestartSec = 1;
    #       };
    #     };
    #   };
    # };
    xdg = {
      configFile = {
        "espanso" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Repos/dotfiles-submodules/totten"; };
      };
    };
  };
}
