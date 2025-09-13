{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  programs.zen-browser = {
    enable = false;
    package = (
      flake.inputs.zen-browser.packages.${self.system}.twilight.override {
        policies = {
          disableAppUpdate = true;
          disableTelemetry = true;
        };
      }
    );
  };
}
