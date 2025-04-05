# https://github.com/nix-community/home-manager/issues/2085#issuecomment-2022239332
# https://github.com/nix-community/home-manager/issues/3514#issuecomment-2001362399

{ ... }:
{
  getImports =
    let
      getDir =
        dir:
        builtins.mapAttrs (file: type: if type == "directory" then getDir "${dir}/${file}" else type) (
          builtins.readDir dir
        );

      files =
        dir:
        builtins.collect builtins.isString (
          builtins.matAttrsRecursive (path: type: builtins.concatStringsSep "/" path) (getDir dir)
        );

      validFiles =
        dir:
        map (file: ./. + "/${file}") (
          builtins.filter (file: builtins.hasSuffix ".nix" file && file != "default.nix") (files dir)
        );
    in
    validFiles ./.;
}
