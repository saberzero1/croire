{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = [
        pkgs.python311Full
        pkgs.python311Packages.pandas
        pkgs.python311Packages.matplotlib
        pkgs.python311Packages.seaborn
        pkgs.python311Packages.beautifulsoup4
        pkgs.python311Packages.pip
        pkgs.python311Packages.scikitlearn
        pkgs.python311Packages.numpy
        pkgs.python311Packages.python-dotenv
        pkgs.python311Packages.black
      ];
    };
  };
}
