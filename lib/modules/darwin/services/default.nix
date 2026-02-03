{ flake, ... }:
let
  # Fixes "Too many open files" errors
  ulimit = {
    SoftResourceLimits.NumberOfFiles = 65536;
    HardResourceLimits.NumberOfFiles = 1048576;
  };
in
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;

  launchd = {
    daemons = {
      "org.nixos.activate-system".serviceConfig = ulimit;
      "org.nixos.darwin-store".serviceConfig = ulimit;
      "systems.determinate.nix-daemon".serviceConfig = ulimit;
      "systems.determinate.nix-store".serviceConfig = ulimit;
    };
  };
}
