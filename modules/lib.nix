# Dendritic pattern: Library functions module
# Exports reusable utility functions for use throughout the configuration
{ inputs, ... }:
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
  autoImport =
    dir:
    builtins.map (fn: dir + "/${fn}") (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  # Get a list of filenames (without .nix extension) from a directory
  filesAsNames =
    dir:
    builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf fn)) (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  # Get a list of the contents of all .nix files in a directory as strings
  filesAsStrings =
    dir:
    builtins.map (fn: builtins.readFile (dir + "/${fn}")) (
      builtins.filter (fn: hasSuffix ".nix" fn && fn != "default.nix") (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  # Recursively import all .nix files in a directory tree (excluding default.nix)
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
        builtins.concatLists (
          builtins.attrValues (
            builtins.mapAttrs (
              name: value: if builtins.isAttrs value then files "${d}/${name}" else [ "${d}/${name}" ]
            ) (getDir d)
          )
        );

      validFiles =
        d: builtins.filter (file: hasSuffix ".nix" file && !(hasSuffix "default.nix" file)) (files d);
    in
    validFiles dir;

  # Override a package's license metadata
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
