{ flake, ... }:
let
  inherit (flake.inputs) self;
in
{
  imports = flake.inputs.self.lib.croire.autoImport ./. ++ [
    ./programs
    ./services
    ./settings
    (self + /scripts/rclone.nix)
  ];
}
