{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.git
      ];
    };
    programs = {
      git = {
        config = {
          init = {
            defaultBranch = "master";
          };
          url = {
            "https://github.com/" = {
              insteadOf = [
                "gh:"
                "github:"
              ];
            };
          };
        };
        enable = true;
        package = pkgs.gitFull;
      };
    };
  };
}
