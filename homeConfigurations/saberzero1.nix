{ inputs, ... }@flakeContext:
let
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
    ];
    config = {
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
      };
    };
  };
  nixosModule = { ... }: {
    home-manager.users.saberzero1 = homeModule;
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
