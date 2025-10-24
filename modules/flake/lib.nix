# Reusable utility functions as a flake-parts module
# This exports library functions that can be accessed without relative path calculations
{ ... }:
let
  # Automatically import all .nix files in a directory except default.nix
  # This eliminates the need for the common pattern:
  #   builtins.map (fn: ./${fn}) (
  #     builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  #   )
  #
  # Usage in modules with flake context:
  #   imports = flake.lib.croire.autoImport ./.;
  #
  # Usage in modules with inputs access:
  #   imports = inputs.self.lib.croire.autoImport ./.;
  autoImport =
    dir:
    builtins.map (fn: dir + "/${fn}") (
      builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir))
    );

  # Get a list of filenames (without .nix extension) from a directory
  # Useful for generating lists from filenames (e.g., homebrew casks)
  #
  # Usage:
  #   casks = flake.lib.croire.filesAsNames ./.;
  #   OR
  #   casks = inputs.self.lib.croire.filesAsNames ./.;
  filesAsNames =
    dir:
    builtins.map
      (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf fn))
      (builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir)));

  # Recursively import all .nix files in a directory tree (excluding default.nix)
  # This provides deep auto-importing for nested directory structures
  #
  # Usage:
  #   imports = flake.lib.croire.autoImportRecursive ./.;
  #   OR
  #   imports = inputs.self.lib.croire.autoImportRecursive ./.;
  autoImportRecursive =
    dir:
    let
      getDir =
        d:
        builtins.mapAttrs (file: type: if type == "directory" then getDir "${d}/${file}" else type) (
          builtins.readDir d
        );

      files =
        d:
        builtins.collect builtins.isString (
          builtins.mapAttrsRecursive (path: type: builtins.concatStringsSep "/" path) (getDir d)
        );

      validFiles =
        d:
        builtins.map (file: d + "/${file}") (
          builtins.filter (file: builtins.hasSuffix ".nix" file && file != "default.nix") (files d)
          );
    in
    validFiles dir;
in
{
  # Export to flake.lib.croire for use throughout the configuration
  # This makes functions available as:
  #   - flake.lib.croire.* (in modules with flake context)
  #   - inputs.self.lib.croire.* (in modules with inputs access)
  flake.lib.croire = {
    inherit autoImport filesAsNames autoImportRecursive;
  };
}
