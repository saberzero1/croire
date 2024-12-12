{ pkgs, ... }:
{
  services = {
    espanso = {
      enable = true;
      # package = pkgs.espanso;
      configs = { };
      matches = { };
    };
  };
}
