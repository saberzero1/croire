{ pkgs, ... }:
{
  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML "$HOME/config/aerospace/aerospace.toml";
    };
  };
}
