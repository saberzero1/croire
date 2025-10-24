# Standalone utility function to automatically import all .nix files in a directory except default.nix
#
# This eliminates the need for the common pattern:
#   builtins.map (fn: ./${fn}) (
#     builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
#   )
#
# Usage in default.nix files:
#   imports = (import ../../../lib/auto-import.nix) ./.;
#
# The number of ../ depends on the file's depth from the repository root.
# For modules/nixos/services/default.nix, use: ../../../lib/auto-import.nix
# For modules/home/shared/default.nix, use: ../../../lib/auto-import.nix
dir:
builtins.map (fn: dir + "/${fn}") (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir dir))
)
