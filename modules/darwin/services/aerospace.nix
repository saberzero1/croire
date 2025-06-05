{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  services.aerospace = {
    enable = false;
    package = pkgs.aerospace;
    settings = pkgs.lib.importTOML "${self}/programs/aerospace/aerospace.toml";
  };
}
