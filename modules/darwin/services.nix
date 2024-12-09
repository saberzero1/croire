{ pkgs, ... }:
{
  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML "/Users/${user}/config/aerospace/aerospace.toml";
    };
  };
}
