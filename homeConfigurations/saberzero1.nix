{ inputs, ... }@flakeContext:
let
  username = inputs.self.username;
  homeModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.self.homeModules.applications
      inputs.self.homeModules.browser
      inputs.self.homeModules.console
      inputs.self.homeModules.desktop
      inputs.self.homeModules.development
      inputs.self.homeModules.git
      inputs.self.homeModules.programming_languages
      inputs.self.homeModules.security
      inputs.self.homeModules.system
      inputs.self.homeModules.utils
      inputs.self.homeModules.workflow
      ../extensions/espanso
    ];
    config = {
      home = {
        stateVersion = "24.05";
        username = username;
        homeDirectory = "/home/${username}";
      };
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };
      programs = {
        home-manager = {
          enable = true;
          path = null;
        };
        espanso = {
          enable = true;
          # serviceConfig = {
          #   execStart = "${config.programs.espanso.package}/bin/espanso start";
          #   Restart = "always";
          #   RestartSec = 1;
          # };
        };
      };
      # systemd = {
        services = {
          espanso = {
            enable = true;
            package = config.programs.espanso;
            # serviceConfig = {
            #   execStart = "${config.programs.espanso.package}/bin/espanso start";
            #   Restart = "always";
            #   RestartSec = 1;
            # };
          };
        };
      # };
    };
  };
  nixosModule = { ... }: {
    home-manager = {
      users.saberzero1 = homeModule;
    };
  };
in
(
  (
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        homeModule
      ];
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    }
  ) // { inherit nixosModule; }
)
