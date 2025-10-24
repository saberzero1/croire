# Library Functions

This directory contains documentation for the reusable utility functions available via the `croire-lib` parameter.

## Usage

All modules in this repository automatically receive the `croire-lib` parameter from their parent modules. This provides access to library functions without any import statements:

```nix
{ croire-lib, ... }:
{
  # Auto-import all .nix files
  imports = croire-lib.autoImport ./.;
  
  # Get filenames as names
  casks = croire-lib.filesAsNames ./.;
  
  # Recursively import (rare use case)
  imports = croire-lib.autoImportRecursive ./.;
}
```

### Benefits:
- ✅ No path calculations needed
- ✅ No import statements required
- ✅ Type-safe via module system
- ✅ More readable code
- ✅ Consistent across all modules

## Available Functions

### croire-lib.autoImport

Automatically imports all `.nix` files in a directory except `default.nix`.

**Usage:**
```nix
{ croire-lib, ... }:
{
  imports = croire-lib.autoImport ./.;
}
```

**Replaces the pattern:**
```nix
imports = builtins.map (fn: ./${fn}) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```

### croire-lib.filesAsNames

Gets a list of filenames (without `.nix` extension) from a directory, excluding `default.nix`.

**Usage:**
```nix
{ croire-lib, ... }:
let
  casks = croire-lib.filesAsNames ./.;
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

### croire-lib.autoImportRecursive

Recursively imports all `.nix` files in a directory tree (excluding `default.nix`).

**Usage:**
```nix
{ croire-lib, ... }:
{
  imports = croire-lib.autoImportRecursive ./.;
}
```

## How It Works

The library functions are defined in `/modules/flake/lib.nix` as a flake-parts module that exports `flake.lib.croire.*`.

Parent modules pass these functions to their children via `_module.args`:

```nix
# In parent module (e.g., modules/nixos/default.nix)
{ flake, ... }:
{
  imports = [ ./services ./packages ];
  
  _module.args = {
    croire-lib = flake.lib.croire;
  };
}
```

Child modules then receive `croire-lib` as a parameter and can use the functions directly without any import statements.
