# Reusable utility functions for the flake
# These functions help eliminate repeated patterns throughout the configuration
{ ... }:
{
  flake.lib = {
    # Automatically import all .nix files in a directory except default.nix
    # This eliminates the need for the common pattern:
    #   builtins.map (fn: ./${fn}) (
    #     builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
    #   )
    #
    # Usage in modules with flake context:
    #   imports = flake.lib.autoImport ./.;
    #
    # Usage as standalone function (for simple default.nix files):
    #   imports = (import ../../../lib/auto-import.nix) ./.;
    autoImport =
      dir:
      builtins.map (fn: dir + "/${fn}") (
        builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir))
      );

    # Get a list of filenames (without .nix extension) from a directory
    # Useful for generating lists from filenames (e.g., homebrew casks)
    #
    # Usage:
    #   casks = flake.lib.filesAsNames ./.;
    filesAsNames =
      dir:
      builtins.map
        (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf fn))
        (builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir)));

    # Recursively import all .nix files in a directory tree (excluding default.nix)
    # This provides deep auto-importing for nested directory structures
    #
    # Usage:
    #   imports = flake.lib.autoImportRecursive ./.;
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
  };
}
