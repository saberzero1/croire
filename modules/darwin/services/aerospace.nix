{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  services.aerospace = {
    enable = false;
    package = pkgs.aerospace;
  };
}
