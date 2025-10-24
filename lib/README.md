# Library Functions

This directory contains reusable utility functions for the Croire Nix configuration.

## Available Functions

### auto-import.nix

Automatically imports all `.nix` files in a directory except `default.nix`.

**Usage:**
```nix
{ ... }:
{
  imports = (import ../../../lib/auto-import.nix) ./.;
}
```

**Replaces the pattern:**
```nix
imports = builtins.map (fn: ./${fn}) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```

### files-as-names.nix

Gets a list of filenames (without `.nix` extension) from a directory, excluding `default.nix`.

**Usage:**
```nix
{ ... }:
let
  casks = (import ../../../../lib/files-as-names.nix) ./.;
in
{
  homebrew.casks = casks;
}
```

**Replaces the pattern:**
```nix
casks = builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn})) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```

## Flake Library Functions

These functions are also available via the flake library for modules that have access to the `flake` context:

```nix
{ flake, ... }:
{
  # Auto-import all .nix files
  imports = flake.lib.autoImport ./.;
  
  # Get filenames as names
  casks = flake.lib.filesAsNames ./.;
  
  # Recursively import all .nix files in a directory tree
  imports = flake.lib.autoImportRecursive ./.;
}
```

See `/modules/flake/lib.nix` for the flake library implementation.

## Path Calculation

The number of `../` needed depends on the file's depth from the repository root:

- `modules/nixos/services/default.nix` → `../../../lib/auto-import.nix`
- `modules/home/shared/programs/default.nix` → `../../../../lib/auto-import.nix`
- `modules/home/shared/programs/lazyvim/plugins/default.nix` → `../../../../../../lib/auto-import.nix`

Count the directory levels from your file to the repository root, then use that many `../`.
