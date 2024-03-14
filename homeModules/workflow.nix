{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: with builtins {
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
        configs = {
          default = {
            includes = builtins.toJSON ["../../Documents/Repos/dotfiles/totten/config/default.yml"];
          };
        };
        matches = {
          base = [
            {
              includes = builtins.toJSON ["../../Documents/Repos/dotfiles/totten/config/base.yml"];
            }
          ];
        };
      };
    };
  };
}
