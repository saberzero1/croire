# Dendritic pattern: Per-system configuration
# Defines perSystem options (packages, devShells, formatter, etc.)
{ inputs, config, ... }:
{
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
        overlays = lib.attrValues config.flake.overlays;
      };
    in
    {
      # Override _module.args.pkgs to use our overlayed pkgs
      _module.args.pkgs = pkgs';

      # For 'nix fmt'
      formatter = pkgs'.nixfmt;

      # Development shell
      devShells.default = pkgs'.mkShell {
        name = "croire-shell";
        meta.description = "Shell environment for modifying this Nix configuration";
        packages = with pkgs'; [
          just
          nixd
        ];
      };

      # Enables 'nix run' to activate home-manager config
      packages.default = self'.packages.activate or pkgs'.hello;
    };
}
