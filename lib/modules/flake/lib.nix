# Reusable utility functions as a flake-parts module
# This exports library functions that can be used in imports (available early in evaluation)
{ flake, ... }:
let
  # https://noogle.dev/f/lib/warnIf
  warnIf = cond: msg: if cond then builtins.warn msg else x: x;
  # https://noogle.dev/f/lib/strings/hasSuffix
  hasSuffix =
    suffix: content:
    let
      lenContent = builtins.stringLength content;
      lenSuffix = builtins.stringLength suffix;
    in
    # Before 23.05, paths would be copied to the store before converting them
    # to strings and comparing. This was surprising and confusing.
    warnIf (builtins.isPath suffix)
      ''
        lib.strings.hasSuffix: The first argument (${toString suffix}) is a path value, but only strings are supported.
            There is almost certainly a bug in the calling code, since this function always returns `false` in such a case.
            This function also copies the path to the Nix store, which may not be what you want.
            This behavior is deprecated and will throw an error in the future.''
      (
        lenContent >= lenSuffix && builtins.substring (lenContent - lenSuffix) lenContent content == suffix
      );
  # Automatically import all .nix files in a directory except default.nix
  # This eliminates the need for the common pattern:
  #   builtins.map (fn: ./${fn}) (
  #     builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  #   )
  #
  # IMPORTANT: Can be used in imports because it's available via inputs.self.lib
  # Usage in any module:
  #   { flake, ... }: {
  #     imports = flake.inputs.self.lib.croire.autoImport ./.;
  #   }
  autoImport =
    dir:
    builtins.map (fn: dir + "/${fn}") (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  # Get a list of filenames (without .nix extension) from a directory
  # Useful for generating lists from filenames (e.g., homebrew casks)
  #
  # Usage:
  #   { flake, ... }: let
  #     casks = flake.inputs.self.lib.croire.filesAsNames ./.;
  #   in { ... }
  filesAsNames =
    dir:
    builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf fn)) (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );
  # Get a list of the contents of all .nix files in a directory as strings
  # Useful for importing lists of items defined in .nix files (e.g., homebrew casks)
  #
  # Usage:
  #   { flake, ... }: let
  #     casks = flake.inputs.self.lib.croire.filesAsStrings ./.
  #   in { ... }
  filesAsStrings =
    dir:
    builtins.map (fn: builtins.readFile (dir + "/${fn}")) (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  # Recursively import all .nix files in a directory tree (excluding default.nix)
  # This provides deep auto-importing for nested directory structures
  #
  # Usage:
  #   { flake, ... }: {
  #     imports = flake.inputs.self.lib.croire.autoImportRecursive ./.;
  #   }
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
          builtins.filter (file: hasSuffix ".nix" file && file != "default.nix") (files d)
        );
    in
    validFiles dir;
  # This function overrides a package's license metadata to a generic free software license
  # This is solely to circumvent a limitation in evaluating unfree packages in flakes
  # You should still comply with the actual license of the package when using it!
  #
  # Usage:
  #   { flake, pkgs, ... }:
  #   let
  #     inherit (flake.inputs.self.lib.croire) overrideLicense;
  #   in
  #   {
  #     environment.systemPackages = [
  #       (overrideLicense pkgs.somePackage)
  #     ];
  #   }
  overrideLicense =
    pkg:
    pkg.overrideAttrs (oldAttrs: {
      meta = oldAttrs.meta // {
        license = {
          fullName = "Unspecified free software license";
        };
      };
    });
in
{
  # Export to flake.lib.croire for use throughout the configuration
  # This makes functions available as flake.inputs.self.lib.croire.*
  # These can be used even in imports because inputs.self.lib is available early
  flake.lib.croire = {
    inherit
      autoImport
      filesAsNames
      filesAsStrings
      autoImportRecursive
      overrideLicense
      ;
  };
}
