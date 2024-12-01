{ inputs, ... }@flakeContext:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    home = {
      packages = [
        pkgs.python3
        pkgs.python312Packages.pandas
        pkgs.python312Packages.matplotlib
        pkgs.python312Packages.seaborn
        pkgs.python312Packages.beautifulsoup4
        pkgs.python312Packages.pip
        pkgs.python312Packages.scikitlearn
        pkgs.python312Packages.numpy
        pkgs.python312Packages.python-dotenv
        pkgs.python312Packages.black
      ];
    };
  };
  languages.python = {
    enable = true;
    uv.enable = true;
    venv.enable = true;
    venv.requirements = ''
      black
      numpy
      pandas
      matplotlib
      seaborn
      scikitlearn
      beautifulsoup4
      python-dotenv
      jypter
      ipython
    '';
  };
}
