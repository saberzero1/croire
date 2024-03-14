{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
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
          default = [
            {
              includes = "${''"../../Documents/Repos/dotfiles/totten/config/default.yml"''}";
            }
          ];
        };
        matches = {
          base = [
            {
              includes = "${''"../../Documents/Repos/dotfiles/totten/config/base.yml"''}";
            }
          ];
        };
      };
    };
  };
}
