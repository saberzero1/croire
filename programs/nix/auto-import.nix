# This utility has been moved to /lib/auto-import.nix
# For new usages, use: (import ../../lib/auto-import.nix) ./.
# This file is kept for backwards compatibility
builtins.map (fn: ./${fn}) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
)
