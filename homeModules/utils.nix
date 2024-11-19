{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    home = {
      packages = [
        pkgs._7zz
        pkgs.jq
        pkgs.parallel
        pkgs.xclicker
      ];
    };
    programs = {
      jq = {
        colors = {
          arrays = "1;37";
          false = "0;37";
          null = "1;30";
          numbers = "0;37";
          objects = "1;37";
          strings = "0;32";
          true = "0;37";
        };
        enable = true;
        package = pkgs.jq;
      };
      ripgrep = {
        enable = true;
        package = pkgs.ripgrep;
      };
    };
  };
}
