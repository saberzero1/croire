# Standalone utility function to get filenames without .nix extension from a directory
#
# This eliminates the need for the pattern:
#   builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn})) (
#     builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
#   )
#
# Usage in modules:
#   taps = (import ../../../../lib/files-as-names.nix) ./.;
#
# This is useful for generating lists like homebrew casks, taps, or brews from filenames
dir:
builtins.map
  (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf fn))
  (builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir)))
