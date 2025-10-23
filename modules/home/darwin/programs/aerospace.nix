{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.aerospace = {
    enable = true;
    package = pkgs.aerospace;
    launchd = {
      enable = true;
      keepAlive = true;
    };
    userSettings = pkgs.lib.importTOML "${self}/programs/aerospace/aerospace.toml";
  };
}
