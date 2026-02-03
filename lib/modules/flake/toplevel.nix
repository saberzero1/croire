# Top-level flake glue to get our configuration working
{ inputs, ... }:
let
  inherit (inputs) self;
in
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  # Apply overlays to perSystem pkgs
  perSystem =
    {
      self',
      pkgs,
      lib,
      system,
      ...
    }:
    let
      # Apply our overlays to pkgs used in perSystem
      pkgs' = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = lib.attrValues self.overlays;
      };
    in
    {
      # Override _module.args.pkgs to use our overlayed pkgs
      _module.args.pkgs = pkgs';

      # For 'nix fmt'
      formatter = pkgs'.nixpkgs-fmt;

      # Enables 'nix run' to activate.
      packages.default = self'.packages.activate;
    };
}
