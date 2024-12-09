{ pkgs, ... }:
{
  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML /Users/emile/config/aerospace/aerospace.toml;
    };
  };
}
